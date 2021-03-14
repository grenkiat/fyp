# Karcher Vehicle (URDF)

This package contains a plugin to control the Karcher vehicle in Gazebo.

Modifications were made from the SDF version to recreate the Karcher model in URDF.

A sample launchfile is included to load the plugin.

## Using the model

### 1. Dependencies

1. `ROS Melodic`

2. `Gazebo 9`

3. `gazebo_ros_pkgs`:

To install `gazebo_ros_pkgs` in ROS Melodic:

```
sudo apt-get install ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control
```

For more information please refer to the respective [github](https://github.com/ros-simulation/gazebo_ros_pkgs) and [tutorial](http://gazebosim.org/tutorials?tut=ros_installing&cat=connect_ros#Installgazebo_ros_pkgs)

### 2. Installation

Build the plugin using `cmake`, `catkin_make`, etc.

### 3. Setup the plugin

Make sure `GAZEBO_PLUGIN_PATH` has a path to the folder containing `libKarcherUrdfPlugin.so`

```
export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:/example/path/to/plugin/
```

You may add this into your `~./bashrc` to avoid having to do this step in the future. 

The given launchfile automatically spawns the Karcher vehicle via Gazebo's `spawn_model` node. There is no need to change `GAZEBO_MODEL_PATH`.

If you instead wish to spawn the vehicle via Gazebo's model database:

Make sure `GAZEBO_MODEL_PATH` has a path to the `description` folder containing `model.config`

```
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/example/path/.../karcher_urdf/description/
```

Doing so may cause `Missing model.config` errors pointing to `description/meshes` and `description/urdf`, when launching Gazebo. You may safely ignore them.

### 4. Running the launchfile

Run the sample launchfile within the launch folder

```
roslaunch .../karcher_urdf/gazebo/launch/sandbox.launch
```

Note: This launchfile also launches Rviz

### 5. Controlling the Karcher through ROS

#### Throttle

Publish to the ros topic `/karcher_urdf/acc_cmd` with the message type `std_msgs/Float32`

The throttle input is percentage-based (0 to 1)

#### Steering

Publish to the ros topic `/karcher_urdf/steer_cmd` with the message type `std_msgs/Float32`

The steering input is in radians (positive turns left, negative turns right, maximum steer angle of +/- 0.442 radians)

#### Braking

Publish to the ros topic `/karcher_urdf/brake_cmd` with the message type `std_msgs/Float32`

The brake input is percentage-based (0 to 1)

#### Gearbox

Publish to the ros topic `/karcher_urdf/gear_cmd` with the message type `std_msgs/Int8`

The gearbox input has 3 gears (-1 for Reverse, 0 for Neutral, 1 for Forward)

## Output from Gazebo

Multiple types of information are recorded and published onto ROS:

### 1. Velocity

Linear velocity of the vehicle is published to `/karcher_urdf/vel_out` under the message type `std_msgs/Float32`

### 2. Distance/Odometry

Distance travelled by vehicle is published to `/karcher_urdf/dist_out` under the message type `std_msgs/Float32`

### 3. Steering angles

Steering angles for the front wheel is published to `/karcher_urdf/f_angle_out` under the message type `std_msgs/Float32`