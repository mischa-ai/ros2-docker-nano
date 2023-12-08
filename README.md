# ROS 2 Docker container for NVIDIA Jetson Nano

Run ROS 2 in docker container on NVIDIA Jetson Nano


command output `./run.sh dustynv/ros:iron-ros-base-l4t-r32.7.1` from _jetson-containers_

```
docker run --runtime nvidia -it --rm --network host --volume /tmp/argus_socket:/tmp/argus_socket --volume /etc/enctune.conf:/etc/enctune.conf --volume /etc/nv_tegra_release:/etc/nv_tegra_release --volume /tmp/nv_jetson_model:/tmp/nv_jetson_model --volume /home/jetson/jetson-containers/data:/data --device /dev/snd --device /dev/bus/usb --device /dev/video0 dustynv/ros:iron-ros-base-l4t-r32.7.1
```

Create container with name:

```
docker run --user ros --runtime nvidia -it --network host --volume /tmp/argus_socket:/tmp/argus_socket --volume /etc/enctune.conf:/etc/enctune.conf --volume /etc/nv_tegra_release:/etc/nv_tegra_release --volume /tmp/nv_jetson_model:/tmp/nv_jetson_model --volume /home/jetson/jetson-containers/data:/data --device /dev/snd --device /dev/bus/usb --device /dev/video0 --name ros2nano dustynv/ros:iron-ros-base-l4t-r32.7.1
```