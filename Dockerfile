# Use ROS 2 Humble Hawksbill base image
FROM ros:humble-ros-base

# Install development tools and ROS 2 build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# Initialize and update rosdep
# Since the base image already has rosdep initialized, we only need to update it
RUN rosdep update

# Create a ROS 2 workspace
WORKDIR /ros2_ws
RUN mkdir src

# Copy your ROS 2 package source here (assumed to be done via Docker build context)

# Install dependencies with rosdep
# Here we assume that you have packages in your src directory
# If you don't have packages yet, comment out this line
# RUN rosdep install --from-paths src --ignore-src --rosdistro humble -y

# Build the workspace with colcon
# If you don't have packages yet, comment out this line
# RUN /bin/bash -c ". /opt/ros/humble/setup.bash; colcon build"

# Source the workspace
CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && /bin/bash"]
