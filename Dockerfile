FROM arm64v8/ros:iron

# install ros package
RUN apt-get update \
    && apt-get install -y \
        ros-${ROS_DISTRO}-demo-nodes-cpp \
        ros-${ROS_DISTRO}-demo-nodes-py \
        ros-${ROS_DISTRO}-ros2-control \
        ros-${ROS_DISTRO}-ros2-controllers \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# launch ros package
CMD ["ros2", "launch", "demo_nodes_cpp", "talker_listener.launch.py"]