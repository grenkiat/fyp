;; Auto-generated. Do not edit!


(when (boundp 'ee4308_turtle::EE4308MsgMotion)
  (if (not (find-package "EE4308_TURTLE"))
    (make-package "EE4308_TURTLE"))
  (shadow 'EE4308MsgMotion (find-package "EE4308_TURTLE")))
(unless (find-package "EE4308_TURTLE::EE4308MSGMOTION")
  (make-package "EE4308_TURTLE::EE4308MSGMOTION"))

(in-package "ROS")
;;//! \htmlinclude EE4308MsgMotion.msg.html


(defclass ee4308_turtle::EE4308MsgMotion
  :super ros::object
  :slots (_x _y _o _v _w ))

(defmethod ee4308_turtle::EE4308MsgMotion
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:o __o) 0.0)
    ((:v __v) 0.0)
    ((:w __w) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _o (float __o))
   (setq _v (float __v))
   (setq _w (float __w))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:o
   (&optional __o)
   (if __o (setq _o __o)) _o)
  (:v
   (&optional __v)
   (if __v (setq _v __v)) _v)
  (:w
   (&optional __w)
   (if __w (setq _w __w)) _w)
  (:serialization-length
   ()
   (+
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _o
    8
    ;; float64 _v
    8
    ;; float64 _w
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _o
       (sys::poke _o (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _v
       (sys::poke _v (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _w
       (sys::poke _w (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _o
     (setq _o (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _v
     (setq _v (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _w
     (setq _w (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get ee4308_turtle::EE4308MsgMotion :md5sum-) "e21c6318a89f0960f14408642fec1cea")
(setf (get ee4308_turtle::EE4308MsgMotion :datatype-) "ee4308_turtle/EE4308MsgMotion")
(setf (get ee4308_turtle::EE4308MsgMotion :definition-)
      "float64 x
float64 y
float64 o
float64 v
float64 w

")



(provide :ee4308_turtle/EE4308MsgMotion "e21c6318a89f0960f14408642fec1cea")


