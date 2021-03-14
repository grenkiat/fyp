# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "ee4308_turtle: 2 messages, 0 services")

set(MSG_I_FLAGS "-Iee4308_turtle:/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(ee4308_turtle_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg" NAME_WE)
add_custom_target(_ee4308_turtle_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ee4308_turtle" "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg" ""
)

get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg" NAME_WE)
add_custom_target(_ee4308_turtle_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ee4308_turtle" "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ee4308_turtle
)
_generate_msg_cpp(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ee4308_turtle
)

### Generating Services

### Generating Module File
_generate_module_cpp(ee4308_turtle
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ee4308_turtle
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(ee4308_turtle_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(ee4308_turtle_generate_messages ee4308_turtle_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_cpp _ee4308_turtle_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_cpp _ee4308_turtle_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ee4308_turtle_gencpp)
add_dependencies(ee4308_turtle_gencpp ee4308_turtle_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ee4308_turtle_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ee4308_turtle
)
_generate_msg_eus(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ee4308_turtle
)

### Generating Services

### Generating Module File
_generate_module_eus(ee4308_turtle
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ee4308_turtle
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(ee4308_turtle_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(ee4308_turtle_generate_messages ee4308_turtle_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_eus _ee4308_turtle_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_eus _ee4308_turtle_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ee4308_turtle_geneus)
add_dependencies(ee4308_turtle_geneus ee4308_turtle_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ee4308_turtle_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ee4308_turtle
)
_generate_msg_lisp(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ee4308_turtle
)

### Generating Services

### Generating Module File
_generate_module_lisp(ee4308_turtle
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ee4308_turtle
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(ee4308_turtle_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(ee4308_turtle_generate_messages ee4308_turtle_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_lisp _ee4308_turtle_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_lisp _ee4308_turtle_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ee4308_turtle_genlisp)
add_dependencies(ee4308_turtle_genlisp ee4308_turtle_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ee4308_turtle_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ee4308_turtle
)
_generate_msg_nodejs(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ee4308_turtle
)

### Generating Services

### Generating Module File
_generate_module_nodejs(ee4308_turtle
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ee4308_turtle
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(ee4308_turtle_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(ee4308_turtle_generate_messages ee4308_turtle_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_nodejs _ee4308_turtle_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_nodejs _ee4308_turtle_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ee4308_turtle_gennodejs)
add_dependencies(ee4308_turtle_gennodejs ee4308_turtle_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ee4308_turtle_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ee4308_turtle
)
_generate_msg_py(ee4308_turtle
  "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ee4308_turtle
)

### Generating Services

### Generating Module File
_generate_module_py(ee4308_turtle
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ee4308_turtle
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(ee4308_turtle_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(ee4308_turtle_generate_messages ee4308_turtle_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMotion.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_py _ee4308_turtle_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/grenk/catkin_ws/src/ee4308/ee4308_turtle/msg/EE4308MsgMaster.msg" NAME_WE)
add_dependencies(ee4308_turtle_generate_messages_py _ee4308_turtle_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ee4308_turtle_genpy)
add_dependencies(ee4308_turtle_genpy ee4308_turtle_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ee4308_turtle_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ee4308_turtle)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ee4308_turtle
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(ee4308_turtle_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ee4308_turtle)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ee4308_turtle
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(ee4308_turtle_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ee4308_turtle)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ee4308_turtle
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(ee4308_turtle_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ee4308_turtle)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ee4308_turtle
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(ee4308_turtle_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ee4308_turtle)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ee4308_turtle\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ee4308_turtle
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(ee4308_turtle_generate_messages_py std_msgs_generate_messages_py)
endif()
