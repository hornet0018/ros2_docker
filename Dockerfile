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
RUN rosdep init && rosdep update --rosdistro $ROS_DISTRO

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

# create workspace, clone repositories, install dependencies, and build
RUN mkdir -p /root/ros2_ws/src && \
    cd /root/ros2_ws/src && \
    git clone https://github.com/hornet0018/switchbot_ros2.git && \
    git clone https://github.com/hornet0018/udco2s_ros2.git && \
    git clone -b humble https://github.com/micro-ROS/micro_ros_setup.git && \
    cd .. && \
    rosdep install --from-paths src --ignore-src -y && \
    colcon build

# source the workspace setup file
CMD ["/bin/bash", "-c", "source /root/ros2_ws/install/setup.bash && /bin/bash"]
