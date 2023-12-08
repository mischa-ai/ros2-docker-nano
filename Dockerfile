FROM dustynv/ros:iron-ros-base-l4t-r32.7.1

ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir /home/$USERNAME/.config \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME \
    && echo "source /opt/ros/iron/setup.bash" >> $HOME/.bashrc

# Set environment variables for user configuration
ENV HOME /home/$USERNAME
ENV USER $USERNAME

WORKDIR $HOME/ros2_ws

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        vim \
        python3-pip \
        python3-rosdep \
        python3-colcon-common-extensions \
        python3-vcstool \
        python3-rosinstall-generator \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN source /opt/ros/iron/setup.bash \
    && rosdep init \
    && rosdep update

RUN mkdir -p $HOME/ros2_ws/src \
    && cd $HOME/ros2_ws/src \
    && rosinstall_generator \
        ros2_control \
        ros2-controllers \
        --rosdistro iron --deps --tar > ros2_control.rosinstall \
    && wstool init src $HOME/ros2_ws/src/ros2_control.rosinstall \
    && source /opt/ros/iron/setup.bash \
    && rosdep install --from-paths src --ignore-src -r -y \
    && colcon build

# Source ros2_control workspace
RUN echo "source /opt/ros/iron/setup.bash" >> $HOME/.bashrc
RUN echo "source $HOME/ros2_ws/install/local_setup.bash" >> $HOME/.bashrc

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["bash"]
