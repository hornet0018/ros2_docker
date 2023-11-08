# Use ROS 2 Humble Hawksbill core image as the base
FROM ros:humble-ros-core-jammy

# Install development tools and ROS 2 build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init && rosdep update --rosdistro humble

# Create a ROS 2 workspace and clone the necessary repositories
RUN mkdir -p /root/ros2_ws/src && \
    cd /root/ros2_ws/src && \
    git clone https://github.com/hornet0018/switchbot_ros2.git && \
    git clone https://github.com/hornet0018/udco2s_ros2.git && \
    git clone -b humble https://github.com/micro-ROS/micro_ros_setup.git

# Install any missing dependencies for the workspace
RUN cd /root/ros2_ws && \
    rosdep install --from-paths src --ignore-src -y

# Build the workspace
RUN cd /root/ros2_ws && \
    . /opt/ros/humble/setup.bash && \
    colcon build

# When the container launches, source the workspace
CMD ["/bin/bash", "-c", "source /root/ros2_ws/install/setup.bash && /bin/bash"]
