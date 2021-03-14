
(cl:in-package :asdf)

(defsystem "ee4308_turtle-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "EE4308MsgMaster" :depends-on ("_package_EE4308MsgMaster"))
    (:file "_package_EE4308MsgMaster" :depends-on ("_package"))
    (:file "EE4308MsgMotion" :depends-on ("_package_EE4308MsgMotion"))
    (:file "_package_EE4308MsgMotion" :depends-on ("_package"))
  ))