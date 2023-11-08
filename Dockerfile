# This is an auto generated Dockerfile for ros:ros-base
# generated from docker_images_ros2/create_ros_image.Dockerfile.em
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

# bootstrap rosdep
# no need to call rosdep init since the base image already does this
RUN rosdep update --rosdistro $ROS_DISTRO

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

# create a ROS 2 workspace
WORKDIR /ros2_ws
RUN mkdir src

# copy over your ROS 2 package(s) into the container's workspace
# you would typically use the COPY command here to copy your package(s) from your host to the container's workspace
# COPY ./my_ros2_package /ros2_ws/src/my_ros2_package

# install dependencies with rosdep
# make sure you have your package or packages copied to the src directory before this step
RUN rosdep install --from-paths src --ignore-src --rosdistro humble -y

# build the workspace with colcon
RUN /bin/bash -c ". /opt/ros/$ROS_DISTRO/setup.bash; colcon build"

# source the workspace
CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && /bin/bash"]
