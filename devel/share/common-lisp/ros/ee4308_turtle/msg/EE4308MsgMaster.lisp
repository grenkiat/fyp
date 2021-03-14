; Auto-generated. Do not edit!


(cl:in-package ee4308_turtle-msg)


;//! \htmlinclude EE4308MsgMaster.msg.html

(cl:defclass <EE4308MsgMaster> (roslisp-msg-protocol:ros-message)
  ((seq
    :reader seq
    :initarg :seq
    :type cl:integer
    :initform 0)
   (stop
    :reader stop
    :initarg :stop
    :type cl:boolean
    :initform cl:nil)
   (target_x
    :reader target_x
    :initarg :target_x
    :type cl:float
    :initform 0.0)
   (target_y
    :reader target_y
    :initarg :target_y
    :type cl:float
    :initform 0.0))
)

(cl:defclass EE4308MsgMaster (<EE4308MsgMaster>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EE4308MsgMaster>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EE4308MsgMaster)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ee4308_turtle-msg:<EE4308MsgMaster> is deprecated: use ee4308_turtle-msg:EE4308MsgMaster instead.")))

(cl:ensure-generic-function 'seq-val :lambda-list '(m))
(cl:defmethod seq-val ((m <EE4308MsgMaster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ee4308_turtle-msg:seq-val is deprecated.  Use ee4308_turtle-msg:seq instead.")
  (seq m))

(cl:ensure-generic-function 'stop-val :lambda-list '(m))
(cl:defmethod stop-val ((m <EE4308MsgMaster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ee4308_turtle-msg:stop-val is deprecated.  Use ee4308_turtle-msg:stop instead.")
  (stop m))

(cl:ensure-generic-function 'target_x-val :lambda-list '(m))
(cl:defmethod target_x-val ((m <EE4308MsgMaster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ee4308_turtle-msg:target_x-val is deprecated.  Use ee4308_turtle-msg:target_x instead.")
  (target_x m))

(cl:ensure-generic-function 'target_y-val :lambda-list '(m))
(cl:defmethod target_y-val ((m <EE4308MsgMaster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ee4308_turtle-msg:target_y-val is deprecated.  Use ee4308_turtle-msg:target_y instead.")
  (target_y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EE4308MsgMaster>) ostream)
  "Serializes a message object of type '<EE4308MsgMaster>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'seq)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'seq)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'seq)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'seq)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stop) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EE4308MsgMaster>) istream)
  "Deserializes a message object of type '<EE4308MsgMaster>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'stop) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_y) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EE4308MsgMaster>)))
  "Returns string type for a message object of type '<EE4308MsgMaster>"
  "ee4308_turtle/EE4308MsgMaster")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EE4308MsgMaster)))
  "Returns string type for a message object of type 'EE4308MsgMaster"
  "ee4308_turtle/EE4308MsgMaster")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EE4308MsgMaster>)))
  "Returns md5sum for a message object of type '<EE4308MsgMaster>"
  "0effaf0c54ed4fd8e29b0800cfb2a4e3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EE4308MsgMaster)))
  "Returns md5sum for a message object of type 'EE4308MsgMaster"
  "0effaf0c54ed4fd8e29b0800cfb2a4e3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EE4308MsgMaster>)))
  "Returns full string definition for message of type '<EE4308MsgMaster>"
  (cl:format cl:nil "uint32 seq~%bool stop~%float64 target_x~%float64 target_y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EE4308MsgMaster)))
  "Returns full string definition for message of type 'EE4308MsgMaster"
  (cl:format cl:nil "uint32 seq~%bool stop~%float64 target_x~%float64 target_y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EE4308MsgMaster>))
  (cl:+ 0
     4
     1
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EE4308MsgMaster>))
  "Converts a ROS message object to a list"
  (cl:list 'EE4308MsgMaster
    (cl:cons ':seq (seq msg))
    (cl:cons ':stop (stop msg))
    (cl:cons ':target_x (target_x msg))
    (cl:cons ':target_y (target_y msg))
))
