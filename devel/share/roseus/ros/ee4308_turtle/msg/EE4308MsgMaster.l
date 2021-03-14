;; Auto-generated. Do not edit!


(when (boundp 'ee4308_turtle::EE4308MsgMaster)
  (if (not (find-package "EE4308_TURTLE"))
    (make-package "EE4308_TURTLE"))
  (shadow 'EE4308MsgMaster (find-package "EE4308_TURTLE")))
(unless (find-package "EE4308_TURTLE::EE4308MSGMASTER")
  (make-package "EE4308_TURTLE::EE4308MSGMASTER"))

(in-package "ROS")
;;//! \htmlinclude EE4308MsgMaster.msg.html


(defclass ee4308_turtle::EE4308MsgMaster
  :super ros::object
  :slots (_seq _stop _target_x _target_y ))

(defmethod ee4308_turtle::EE4308MsgMaster
  (:init
   (&key
    ((:seq __seq) 0)
    ((:stop __stop) nil)
    ((:target_x __target_x) 0.0)
    ((:target_y __target_y) 0.0)
    )
   (send-super :init)
   (setq _seq (round __seq))
   (setq _stop __stop)
   (setq _target_x (float __target_x))
   (setq _target_y (float __target_y))
   self)
  (:seq
   (&optional __seq)
   (if __seq (setq _seq __seq)) _seq)
  (:stop
   (&optional __stop)
   (if __stop (setq _stop __stop)) _stop)
  (:target_x
   (&optional __target_x)
   (if __target_x (setq _target_x __target_x)) _target_x)
  (:target_y
   (&optional __target_y)
   (if __target_y (setq _target_y __target_y)) _target_y)
  (:serialization-length
   ()
   (+
    ;; uint32 _seq
    4
    ;; bool _stop
    1
    ;; float64 _target_x
    8
    ;; float64 _target_y
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _seq
       (write-long _seq s)
     ;; bool _stop
       (if _stop (write-byte -1 s) (write-byte 0 s))
     ;; float64 _target_x
       (sys::poke _target_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_y
       (sys::poke _target_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _seq
     (setq _seq (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _stop
     (setq _stop (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float64 _target_x
     (setq _target_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_y
     (setq _target_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get ee4308_turtle::EE4308MsgMaster :md5sum-) "0effaf0c54ed4fd8e29b0800cfb2a4e3")
(setf (get ee4308_turtle::EE4308MsgMaster :datatype-) "ee4308_turtle/EE4308MsgMaster")
(setf (get ee4308_turtle::EE4308MsgMaster :definition-)
      "uint32 seq
bool stop
float64 target_x
float64 target_y

")



(provide :ee4308_turtle/EE4308MsgMaster "0effaf0c54ed4fd8e29b0800cfb2a4e3")


