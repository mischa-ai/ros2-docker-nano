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

# change the locale from POSIX to UTF-8 - already done in base image
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends locales \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get clean

# RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
# ENV LANG=en_US.UTF-8
# ENV PYTHONIOENCODING=utf-8

# set Python3 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends g++-8 && \
#     rm -rf /var/lib/apt/lists/* && \
#     apt-get clean

# RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100

# install gcc 9

RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y

RUN apt-get update && apt-get install -y gcc-9 g++-9

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

RUN update-alternatives --set gcc /usr/bin/gcc-9 && \
    update-alternatives --set g++ /usr/bin/g++-9

RUN echo "Compiler version: $(g++ --version)"

ENV CC="/usr/bin/gcc-9"
ENV CXX="/usr/bin/g++-9"


    
# build ROS from source
#COPY ros2_build.sh ros2_build.sh
#RUN bash ./ros2_build.sh

# test c++ version
COPY ros2_build_test.sh ros2_build_test4.sh
RUN bash ./ros2_build_test4.sh

# Set the default DDS middleware to cyclonedds
# https://github.com/ros2/rclcpp/issues/1335
#ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# commands will be appended/run by the entrypoint which sources the ROS environment
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

WORKDIR /