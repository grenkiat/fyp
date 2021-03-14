cmake_minimum_required(VERSION 3.0.2)
project(karcher_urdf)

find_package(catkin REQUIRED)

find_package(roscpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(tf REQUIRED)
include_directories(${roscpp_INCLUDE_DIRS})
include_directories(${std_msgs_INCLUDE_DIRS})
include_directories(${tf_INCLUDE_DIRS})

find_package(gazebo REQUIRED)
include_directories(${GAZEBO_INCLUDE_DIRS})
link_directories(${GAZEBO_LIBRARY_DIRS})

add_executable(vel vel.cc)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GAZEBO_CXX_FLAGS}")
add_library(KarcherUrdfPlugin SHARED ../gazebo/plugins/KarcherUrdfPlugin.cc)
add_library(velodyne_plugin SHARED ../gazebo/plugins/velodyne_plugin.cc)
target_link_libraries(KarcherUrdfPlugin vel ${GAZEBO_LIBRARIES} ${roscpp_LIBRARIES} ${tf_LIBRARIES})
target_link_libraries(velodyne_plugin ${GAZEBO_LIBRARIES})
