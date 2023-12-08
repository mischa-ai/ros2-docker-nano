FROM dustynv/ros:iron-ros-base-l4t-r32.7.1

ARG ROS_PACKAGE=ros_base
ARG ROS_VERSION=iron

ENV ROS_DISTRO=${ROS_VERSION}
ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
ENV ROS_PYTHON_VERSION=3

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"] 

WORKDIR /tmp

# change the locale from POSIX to UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends locales \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV PYTHONIOENCODING=utf-8

# set Python3 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
    
# build ROS from source
COPY ros2_build.sh ros2_build.sh
RUN bash ./ros2_build.sh

# Set the default DDS middleware to cyclonedds
# https://github.com/ros2/rclcpp/issues/1335
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# commands will be appended/run by the entrypoint which sources the ROS environment
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

WORKDIR /