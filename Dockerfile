# ROS 2 Humble Hawksbillの公式ベースイメージを使用
FROM ros:humble-ros-base

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*
