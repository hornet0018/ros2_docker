# ROS 2 Humble Hawksbill の公式イメージをベースにする
FROM ros:humble-ros-base

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    # キャッシュされたファイルを削除してイメージサイズを減らす
    && rm -rf /var/lib/apt/lists/*

# rosdep を初期化してアップデート
RUN rosdep init && rosdep update

# ワークスペースの作成
WORKDIR /ros2_ws
RUN mkdir src

# パッケージの依存関係をインストール
# ここでは、まだsrcフォルダにROS 2パッケージはないので、このステップは省略します。
# 実際のプロジェクトで必要なパッケージを含める場合、rosdep install コマンドを実行して依存関係をインストールします。

# ワークスペースをビルド
# ここでも、まだsrcフォルダにパッケージがないため、ビルドするものはありません。
# 実際のプロジェクトでビルドを行うには、パッケージをsrcフォルダに追加する必要があります。
RUN /bin/bash -c ". /opt/ros/humble/setup.bash; colcon build"

# コンテナ起動時にワークスペースの環境をソースする
CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && /bin/bash"]
# ROS 2 Humble Hawksbill の公式イメージをベースにする
FROM ros:humble-ros-base

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    # キャッシュされたファイルを削除してイメージサイズを減らす
    && rm -rf /var/lib/apt/lists/*

# rosdep を初期化してアップデート
RUN rosdep init && rosdep update

# ワークスペースの作成
WORKDIR /ros2_ws
RUN mkdir src

# パッケージの依存関係をインストール
# ここでは、まだsrcフォルダにROS 2パッケージはないので、このステップは省略します。
# 実際のプロジェクトで必要なパッケージを含める場合、rosdep install コマンドを実行して依存関係をインストールします。

# ワークスペースをビルド
# ここでも、まだsrcフォルダにパッケージがないため、ビルドするものはありません。
# 実際のプロジェクトでビルドを行うには、パッケージをsrcフォルダに追加する必要があります。
RUN /bin/bash -c ". /opt/ros/humble/setup.bash; colcon build"

# コンテナ起動時にワークスペースの環境をソースする
CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && /bin/bash"]
