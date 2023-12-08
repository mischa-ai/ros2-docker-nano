# ROS 2 Docker container for NVIDIA Jetson Nano

## Build ROS2 Image

Build ROS 2 docker image on NVIDIA Jetson Nano

```
docker build --network host -t ros2-docker-nano:latest .
```

## Run ROS2 Container

Run ROS 2 in docker container on NVIDIA Jetson Nano

```
docker run --runtime nvidia -it --network host --volume /tmp/argus_socket:/tmp/argus_socket --volume /etc/enctune.conf:/etc/enctune.conf --volume /etc/nv_tegra_release:/etc/nv_tegra_release --volume /tmp/nv_jetson_model:/tmp/nv_jetson_model --volume /home/jetson/jetson-containers/data:/data --device /dev/snd --device /dev/bus/usb --device /dev/video0 --name ros2nano ros2-docker-nano
```
