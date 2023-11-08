# ROS 2 Humble Hawksbill の公式イメージをベースにする
FROM ros:humble-ros-base

# パッケージのリストをアップデート
RUN apt-get update && apt-get install -y \
    # colcon をビルドツールとしてインストール
    python3-colcon-common-extensions \
    # 依存関係のあるパッケージをインストール
    build-essential \
    cmake \
    git \
    python3-rosdep \
    python3-vcstool \
    wget \
    # micro-ROS agentの依存関係
    python3-pip \
    && python3 -m pip install --upgrade pip \
    && pip install colcon-common-extensions \
    && pip install micro-ros-agent \
    # キャッシュされたファイルを削除してイメージサイズを減らす
    && rm -rf /var/lib/apt/lists/*

# rosdep を初期化
RUN rosdep init \
    && rosdep update

# ワークスペースのディレクトリを作成
WORKDIR /ros2_ws
RUN mkdir src

# switchbot_ros2 リポジトリをクローン
RUN git clone https://github.com/hornet0018/switchbot_ros2.git src/switchbot_ros2

# udco2s_ros2 リポジトリをクローン（developブランチ）
RUN git clone --branch develop https://github.com/hornet0018/udco2s_ros2.git src/udco2s_ros2

# ワークスペースの依存関係をインストール
RUN rosdep install -y \
    --from-paths src \
    --ignore-src \
    --rosdistro humble

# ワークスペースをビルド
RUN /bin/bash -c ". /opt/ros/humble/setup.bash; colcon build"

# コンテナが起動した時にワークスペースの環境をソースする
CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && /bin/bash"]