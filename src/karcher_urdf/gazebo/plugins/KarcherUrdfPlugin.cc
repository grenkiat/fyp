#ifndef _KARCHER_URDF_PLUGIN_HH_
#define _KARCHER_URDF_PLUGIN_HH_

#include <thread>
#include "ros/ros.h"
#include "ros/callback_queue.h"
#include "ros/subscribe_options.h"
#include "ros/advertise_options.h"
#include "ros/advertise_service_options.h"
#include "std_msgs/Float32.h"
#include "std_msgs/Int8.h"
#include "std_srvs/Empty.h"
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo_msgs/GetLinkState.h>
#include <gazebo/common/PID.hh>
#include <gazebo/common/Time.hh>
#include <ignition/math/Vector3.hh>
#include <ignition/math/Pose3.hh>
#include <ignition/math/Quaternion.hh>
#include <tf/transform_broadcaster.h>

namespace gazebo
{
	class KarcherUrdfPlugin : public ModelPlugin
	{
		// Constructor
		public: KarcherUrdfPlugin() {}

		public: virtual void Load(physics::ModelPtr _model, sdf::ElementPtr _sdf)
		{
			// Safety check
			if (_model->GetJointCount() == 0)
			{
				std::cerr << "No joints found, plugin will not load\n";
				return;
			}

			// Store model and world pointers for convenience.
			this->model = _model;

			this->world = _model->GetWorld();

			// Find and assign pointer for chassis link
			this->chassisLink = _model->GetLink(_model->GetName() + "::" + "chassis");
			// ----------------------------------------------------------------------------------
			// Find and assign pointers for each wheel joint
			jointname = _model->GetName() + "::" + "front_wheel_joint";
			fWheelJoint = _model->GetJoint(jointname);
			if (!fWheelJoint) 
			{
				std::cerr << "ERROR: Front Wheel Joint missing - plugin will stop loading" << std::endl;
				return;
			}

			jointname = _model->GetName() + "::" + "front_steer_joint";
			fSteerJoint = _model->GetJoint(jointname);
			if (!fSteerJoint) 
			{
				std::cerr << "ERROR: Front Steer Joint missing - plugin will stop loading" << std::endl;
				return;
			}

			jointname = _model->GetName() + "::" + "rear_left_wheel_joint";
			rlJoint = _model->GetJoint(jointname);
			if (!rlJoint) 
			{
				std::cerr << "ERROR: Rear-Left Wheel Joint missing - plugin will stop loading" << std::endl;
				return;
			}

			jointname = _model->GetName() + "::" + "rear_right_wheel_joint";
			rrJoint = _model->GetJoint(jointname);
			if (!rrJoint) 
			{
				std::cerr << "ERROR: Rear-Right Wheel Joint missing - plugin will stop loading" << std::endl;
				return;
			}

			// Get wheel radii of each wheel
			this->fWheelRadius = this->CollisionRadius(this->fWheelJoint->GetChild()->GetCollision(0));
			this->rlWheelRadius = this->CollisionRadius(this->rlJoint->GetChild()->GetCollision(0));
			this->rrWheelRadius = this->CollisionRadius(this->rlJoint->GetChild()->GetCollision(0));
			// ----------------------------------------------------------------------------------
			// Get joint frictions from model SDF
			this->fJointFriction = this->fWheelJoint->GetParam("friction", 0);
			this->rlJointFriction = this->rlJoint->GetParam("friction", 0);
			this->rrJointFriction = this->rrJoint->GetParam("friction", 0);

			// ----------------------------------------------------------------------------------
			// Retrieve plugin parameters from model SDF
			paramName = "max_steer";
			paramDefault = 0.6;
			if (_sdf->HasElement(paramName))
				this->maxSteer = _sdf->Get<double>(paramName);
			else
				this->maxSteer = paramDefault;

			paramName = "max_speed";
			paramDefault = 10;
			if (_sdf->HasElement(paramName))
				this->maxSpeed = _sdf->Get<double>(paramName);
			else
				this->maxSpeed = paramDefault;

			paramName = "chassis_aero_force_gain";
			paramDefault = 1;
			if (_sdf->HasElement(paramName))
				this->dragCoeff = _sdf->Get<double>(paramName);
			else
				this->dragCoeff = paramDefault;
		
			paramName = "fwheel_steering_p_gain";
			paramDefault = 0;
			if (_sdf->HasElement(paramName))
				this->fWheelSteeringPID.SetPGain(_sdf->Get<double>(paramName));
			else
				this->fWheelSteeringPID.SetPGain(paramDefault);
		
			paramName = "fwheel_steering_i_gain";
			paramDefault = 0;
			if (_sdf->HasElement(paramName))
				this->fWheelSteeringPID.SetIGain(_sdf->Get<double>(paramName));
			else
				this->fWheelSteeringPID.SetIGain(paramDefault);
		
			paramName = "fwheel_steering_d_gain";
			paramDefault = 0;
			if (_sdf->HasElement(paramName))
				this->fWheelSteeringPID.SetDGain(_sdf->Get<double>(paramName));
			else
				this->fWheelSteeringPID.SetDGain(paramDefault);

			paramName = "front_torque";
			paramDefault = 0;
			if (_sdf->HasElement(paramName)) 
				this->frontTorque = _sdf->Get<double>(paramName);
			else 
				this->frontTorque = paramDefault;
	
			paramName = "back_torque";
			paramDefault = 2000;
			if (_sdf->HasElement(paramName)) 
				this->rearTorque = _sdf->Get<double>(paramName);
			else 
				this->rearTorque = paramDefault;
	
			paramName = "front_brake_torque";
			paramDefault = 2000;
			if (_sdf->HasElement(paramName))
				this->frontBrakeTorque = _sdf->Get<double>(paramName);
			else
				this->frontBrakeTorque = paramDefault;
	
			paramName = "back_brake_torque";
			paramDefault = 2000;
			if (_sdf->HasElement(paramName))
				this->rearBrakeTorque = _sdf->Get<double>(paramName);
			else
				this->rearBrakeTorque = paramDefault;
	
			paramName = "wheel_base";
			paramDefault = 1;
			if (_sdf->HasElement(paramName))
				this->wheelbase = _sdf->Get<double>(paramName);
			else
				this->wheelbase = paramDefault;
	
			paramName = "rear_track";
			paramDefault = 1;
			if (_sdf->HasElement(paramName))
				this->rearTrack = _sdf->Get<double>(paramName);
			else
				this->rearTrack = paramDefault;

			// ----------------------------------------------------------------------------------

			lastSimTime = this->world->SimTime();
			// Initialize ros, if it has not already been initialized.
			if (!ros::isInitialized())
			{
				int argc = 0;
				char **argv = NULL;
				ros::init(argc, argv, "gazebo_client",
						ros::init_options::NoSigintHandler);
			}
			
			// Initialise ros communication node
			this->rosNode.reset(new ros::NodeHandle("gazebo_client"));
			
			// Subscribe to acceleration topic
			ros::SubscribeOptions accSO =
				ros::SubscribeOptions::create<std_msgs::Float32>(
					"/" + this->model->GetName() + "/acc_cmd",
					1,
					boost::bind(&KarcherUrdfPlugin::accMsg, this, _1),
					ros::VoidPtr(), &this->rosQueue);
			this->accSub = this->rosNode->subscribe(accSO);

			// Subscribe to steering topic
			ros::SubscribeOptions steerSO =
				ros::SubscribeOptions::create<std_msgs::Float32>(
					"/" + this->model->GetName() + "/steer_cmd",
					1,
					boost::bind(&KarcherUrdfPlugin::steerMsg, this, _1),
					ros::VoidPtr(), &this->rosQueue);
			this->steerSub = this->rosNode->subscribe(steerSO);
			
			// Subscribe to braking topic
			ros::SubscribeOptions brakeSO =
				ros::SubscribeOptions::create<std_msgs::Float32>(
					"/" + this->model->GetName() + "/brake_cmd",
					1,
					boost::bind(&KarcherUrdfPlugin::brakeMsg, this, _1),
					ros::VoidPtr(), &this->rosQueue);
			this->brakeSub = this->rosNode->subscribe(brakeSO);

			// Subscribe to gear topic
			ros::SubscribeOptions gearSO =
				ros::SubscribeOptions::create<std_msgs::Int8>(
					"/" + this->model->GetName() + "/gear_cmd",
					1,
					boost::bind(&KarcherUrdfPlugin::gearMsg, this, _1),
					ros::VoidPtr(), &this->rosQueue);
			this->gearSub = this->rosNode->subscribe(gearSO);

			// Advertise velocity topic
			ros::AdvertiseOptions velAO =
				ros::AdvertiseOptions::create<std_msgs::Float32>(
					"/" + this->model->GetName() + "/vel_out",
					1,
					NULL, NULL,
					ros::VoidPtr(), &this->rosQueue);
			this->velPub = this->rosNode->advertise(velAO);

			// Advertise distance topic
			ros::AdvertiseOptions distAO =
				ros::AdvertiseOptions::create<std_msgs::Float32>(
					"/" + this->model->GetName() + "/dist_out",
					1,
					NULL, NULL,
					ros::VoidPtr(), &this->rosQueue);
			this->distPub = this->rosNode->advertise(distAO);

			// Advertise steering angle topic
			ros::AdvertiseOptions fAngleAO =
				ros::AdvertiseOptions::create<std_msgs::Float32>(
					"/" + this->model->GetName() + "/f_angle_out",
					1,
					NULL, NULL,
					ros::VoidPtr(), &this->rosQueue);
			this->fAnglePub = this->rosNode->advertise(fAngleAO);

			// Advertise reset vehicle service
			ros::AdvertiseServiceOptions resetASO =
				ros::AdvertiseServiceOptions::create<std_srvs::Empty>(
					"/" + this->model->GetName() + "/reset_vehicle",
					boost::bind(&KarcherUrdfPlugin::resetVehicle, this, _1, _2),
					ros::VoidPtr(), &this->rosQueue);
			this->resetSrv = this->rosNode->advertiseService(resetASO);

			this->tfTick = 0;

			// Spin up the queue helper thread for subscribing and publishing
			this->rosQueueThread =
				std::thread(std::bind(&KarcherUrdfPlugin::rosQueueHelper, this));

			// Spin up thread for tf publish
			this->tfThread =
				std::thread(std::bind(&KarcherUrdfPlugin::tfQueue, this));

			// Setup an update function that is called for every time-step in the simulation
			this->UpdateConnection = event::Events::ConnectWorldUpdateBegin(std::bind(&KarcherUrdfPlugin::Update, this));
		}


		// This function is called once per time-step
		public: void Update()
		{
			common::Time curTime = this->world->SimTime();
			double dt = (curTime - this->lastSimTime).Double();
			// skip update if invalid dt
			if (dt<=0) {
				std::cerr << "ERROR: Invalid time difference - skipping update step" << std::endl;
				return;
			}

			this->lastSimTime = curTime;

			ignition::math::Vector3d chassisVector = this->chassisLink->WorldCoGLinearVel();

			// Update linear velocity
			this->chassisLinVel = chassisVector.Length();
			this->velMsg.data = this->chassisLinVel;
			this->velPub.publish(this->velMsg);

			// Update distance travelled
			this->odometer += this->chassisLinVel * dt;
			this->distMsg.data = this->odometer;
			this->distPub.publish(this->distMsg);

			// Update steering angle
			double fAngle = this->fSteerJoint->Position(0);
			this->fAngleMsg.data = fAngle;
			this->fAnglePub.publish(this->fAngleMsg);

			// ------------------------------------------------------------------------------
			// AERODYNAMIC DRAG
			// F = - C * |V|^2 * unit vector of V
			// C : drag coefficient of chassis
			// V : velocity vector of chassis
			auto dragForce = -this->dragCoeff * chassisVector.SquaredLength() * chassisVector.Normalized();
			this->chassisLink->AddForce(dragForce);

			// ------------------------------------------------------------------------------
			// STEERING

			this->inputSteer = clamp(this->inputSteer,-(this->maxSteer),this->maxSteer);

			double fError = fAngle - this->inputSteer;
			
			this->fSteerJoint->SetForce(0, this->fWheelSteeringPID.Update(fError, dt));
			// ------------------------------------------------------------------------------
			// BRAKING

			this->inputBrake = clamp(this->inputBrake, 0, 1.0);

			this->fWheelJoint->SetParam("friction", 0, this->fJointFriction + this->inputBrake * this->frontBrakeTorque);
			this->rlJoint->SetParam("friction", 0, this->rlJointFriction + this->inputBrake * this->rearBrakeTorque);
			this->rrJoint->SetParam("friction", 0, this->rrJointFriction + this->inputBrake * this->rearBrakeTorque);
			// ------------------------------------------------------------------------------
			// ACCELERATION

			this->inputGear = clamp(this->inputGear, -1, 1);
			this->inputTorque = clamp(this->inputTorque, 0, 1.0);

			double fTorque = 0, rlTorque = 0, rrTorque = 0;

			if (fabs(this->fWheelJoint->GetVelocity(1) * this->fWheelRadius) < this->maxSpeed)
			{
				fTorque = this->inputTorque * this->frontTorque * this->inputGear;
			}
			if (fabs(this->rlJoint->GetVelocity(0) * this->rlWheelRadius) < this->maxSpeed &&
				 fabs(this->rrJoint->GetVelocity(0) * this->rrWheelRadius) < this->maxSpeed)
			{
				rlTorque = rrTorque = this->inputTorque * this->rearTorque * this->inputGear;
			}

			this->fWheelJoint->SetForce(0, fTorque);
			this->rlJoint->SetForce(0, rlTorque);
			this->rrJoint->SetForce(0, rrTorque);
		}

		private: double clamp(double in, double min, double max)
		{
			double out=in;
			if (in<min) out=min;
			else if (in>max) out=max;
			return out;
		}

		// This function is called whenever an acceleration message is received
		public: void accMsg(const std_msgs::Float32ConstPtr &_msg)
		{
			inputTorque = _msg->data;
		}

		// This function is called whenever a steering message is received
		public: void steerMsg(const std_msgs::Float32ConstPtr &_msg)
		{
			inputSteer = _msg->data;
		}
		// This function is called whenever a steering message is received
		public: void brakeMsg(const std_msgs::Float32ConstPtr &_msg)
		{
			inputBrake = _msg->data;
		}
		// This function is called whenever a steering message is received
		public: void gearMsg(const std_msgs::Int8ConstPtr &_msg)
		{
			inputGear = _msg->data;
		}

		public: bool resetVehicle(std_srvs::Empty::Request &req,std_srvs::Empty::Response &res)
		{
			// Roll and Pitch is currently swapped for the prius model
			// Put vehicle in upright position while maintaining forward direction
			ignition::math::Pose3d modelPose = this->model->WorldPose();
			double roll = modelPose.Rot().Roll(), yaw = modelPose.Rot().Yaw(), pi = 3.141592;
			if ((roll > (pi/2)) || (roll < -(pi/2))) modelPose.Set(modelPose.Pos(),ignition::math::Quaternion<double>(0,0,yaw+pi));
			else modelPose.Set(modelPose.Pos(),ignition::math::Quaternion<double>(0,0,yaw));
			this->model->SetWorldPose(modelPose);

			// Set model velocity to zero
			this->model->SetLinearVel(ignition::math::Vector3d(0,0,0));

			// Set steer wheel angles to zero
			this->fWheelSteeringPID.Reset();
			this->fSteerJoint->SetPosition(0,0);
			this->fSteerJoint->SetVelocity(0,0);

			// Set rotational wheel velocity to zero
			this->fWheelJoint->SetPosition(0,0);
			this->rlJoint->SetPosition(0,0);
			this->rrJoint->SetPosition(0,0);
			this->fWheelJoint->SetVelocity(0,0);
			this->rlJoint->SetVelocity(0,0);
			this->rrJoint->SetVelocity(0,0);

			// Reset odometer
			this->odometer = 0;

			// Reset time
			this->lastSimTime = this->world->SimTime();
		}


		// Helper functions that retrieve messages as long as node is not terminated
		private: void rosQueueHelper()
		{
			static const double timeout = 0.01;
			while (this->rosNode->ok())
			{
				this->rosQueue.callAvailable(ros::WallDuration(timeout));
			}
		}

		private: void tfQueue() 
		{
			ros::Rate rate(50);
			while (ros::ok()) 
			{
				ignition::math::Pose3d chassisPose = this->chassisLink->WorldPose();
				ignition::math::Vector3d pose = chassisPose.Pos();
				ignition::math::Quaternion<double> rotation = chassisPose.Rot();
				tf::Transform transform;
				transform.setOrigin(tf::Vector3(pose.X(), pose.Y(), pose.Z()));
				transform.setRotation(tf::Quaternion(rotation.X(), rotation.Y(), rotation.Z(), rotation.W()));
				tfb.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "world", "chassis"));
				rate.sleep();
			}
		}

		private: double CollisionRadius(physics::CollisionPtr _coll)
		{
			if (!_coll || !(_coll->GetShape()))
				return 0;
			if (_coll->GetShape()->HasType(gazebo::physics::Base::CYLINDER_SHAPE))
			{
				physics::CylinderShape *cyl =
					static_cast<physics::CylinderShape*>(_coll->GetShape().get());
				return cyl->GetRadius();
			}
			else if (_coll->GetShape()->HasType(physics::Base::SPHERE_SHAPE))
			{
				physics::SphereShape *sph =
					static_cast<physics::SphereShape*>(_coll->GetShape().get());
				return sph->GetRadius();
			}
			return 0;
		}

		private: physics::ModelPtr model;

		private: physics::WorldPtr world;

		// Used to define names of joints
		private: std::string jointname; 

		// Joint pointers to each wheel joint
		private: physics::JointPtr fSteerJoint;
		private: physics::JointPtr fWheelJoint;
		private: physics::JointPtr rlJoint;
		private: physics::JointPtr rrJoint;

		private: physics::LinkPtr chassisLink;

		// Values for inherent joint friction
		private: double fJointFriction = 0;
		private: double rlJointFriction = 0;
		private: double rrJointFriction = 0;

		// Maximum braking torques
		private: double frontBrakeTorque = 0;
		private: double rearBrakeTorque = 0;

		// Maximum throttle torques
		private: double frontTorque = 0;
		private: double rearTorque = 0;

		// Used for searching for and assigning parameters
		private: std::string paramName;
		private: double paramDefault;

		// Maximum range of steering
		private: double maxSteer;

		// Maximum speed of vehicle
		private: double maxSpeed;

		// Drag coefficient of prius
		private: double dragCoeff;

		private: common::PID fWheelSteeringPID;

		private: event::ConnectionPtr UpdateConnection;

		// Inputs
		private: double inputTorque = 0; // range 0 to 1
		private: double inputSteer = 0; // in radians
		private: double inputBrake = 0; // range 0 to 1
		private: int inputGear = 0; // Gear setting: (1 - Drive) , (0 - Neutral) , (-1 - Reverse)

		// Linear Velocity
		private: double chassisLinVel = 0;

		private: double fWheelRadius;
		private: double rlWheelRadius;
		private: double rrWheelRadius;

		// Distance travelled since plugin load
		private: double odometer = 0;

		private: double fWheelSteeringCmd;

		private: common::Time lastSimTime;

		// Physical dimensions of the vehicle
		private: double wheelbase;
		private: double rearTrack;

		// Node for ROS transport
		private: std::unique_ptr<ros::NodeHandle> rosNode;
		
		// ROS subscribers
		private: ros::Subscriber accSub;
		private: ros::Subscriber steerSub;
		private: ros::Subscriber brakeSub;
		private: ros::Subscriber gearSub;

		private: ros::ServiceServer resetSrv;

		private: int tfTick;

		private: ros::Publisher velPub;
		private: ros::Publisher distPub;
		private: ros::Publisher fAnglePub;

		private: std_msgs::Float32 velMsg;
		private: std_msgs::Float32 distMsg;
		private: std_msgs::Float32 fAngleMsg;

		private: ros::CallbackQueue rosQueue;
		
		// ros thread
		private: std::thread rosQueueThread;
		private: std::thread tfThread;

		private: tf::TransformBroadcaster tfb;
	};

	// Tell Gazebo about this plugin, so that Gazebo can call Load on this plugin.
	GZ_REGISTER_MODEL_PLUGIN(KarcherUrdfPlugin)
}
#endif