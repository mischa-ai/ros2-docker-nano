#!/bin/bash

# this script builds a ROS2 distribution from source
# ROS_DISTRO, ROS_ROOT, ROS_PACKAGE environment variables should be set

echo "ROS2 builder => ROS_DISTRO=$ROS_DISTRO ROS_PACKAGE=$ROS_PACKAGE ROS_ROOT=$ROS_ROOT"

echo "Compiler version: $(gcc --version)"
echo "CMake version: $(cmake --version)"
