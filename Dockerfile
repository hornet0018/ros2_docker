FROM ros:humble-ros-core-jammy

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# initialize rosdep if it hasn't been already initialized
RUN if [ ! -e /etc/ros/rosdep/sources.list.d/20-default.list ]; then rosdep init; fi && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ros-base=0.10.0-1* \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ros2_ws
RUN mkdir src

# If you have ROS 2 packages to add to the workspace, use the COPY command
# COPY ./my_ros2_package /ros2_ws/src/my_ros2_package

# Install dependencies with rosdep
# RUN rosdep install --from-paths src --ignore-src --rosdistro humble -y

# Build the workspace with colcon
# RUN /bin/bash -c ". /opt/ros/$ROS_DISTRO/setup.bash; colcon build"

CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && /bin/bash"]
