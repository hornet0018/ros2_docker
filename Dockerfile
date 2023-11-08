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

# rosdepを更新（初期化はベースイメージで既に行われている）
RUN rosdep update

# ワークスペースのディレクトリを作成
WORKDIR /ros2_ws
RUN mkdir src

# パッケージの依存関係をインストール
# srcディレクトリにパッケージがある場合は、以下の行のコメントを外して実行する
# RUN rosdep install --from-paths src --ignore-src --rosdistro humble -y

# ワークスペースをビルド
# srcディレクトリにパッケージがある場合は、以下の行のコメントを外して実行する
# RUN /bin/bash -c ". /opt/ros/humble/setup.bash; colcon build"

# シェルスクリプト実行時にワークスペース環境をソースする
CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && /bin/bash"]
