FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Ferramentas básicas + build + rosdep/colcon
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl wget gnupg lsb-release \
    python3-rosdep python3-colcon-common-extensions python3-vcstool \
    build-essential cmake pkg-config \
    libopenvdb-dev \
    && rm -rf /var/lib/apt/lists/*

# --- Instalar Ignition Fortress (Gazebo Sim 6) via repo da OSRF ---
# (comandos conforme docs oficiais do Fortress)
RUN apt-get update && apt-get install -y lsb-release gnupg curl && \
    curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/gazebo-stable.list && \
    apt-get update && \
    apt-get install -y ignition-fortress && \
    rm -rf /var/lib/apt/lists/*
# Observação: o comando do simulador será `ign gazebo` (Fortress). :contentReference[oaicite:1]{index=1}

# ROS packages típicos para este stack
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-slam-toolbox \
    ros-humble-pointcloud-to-laserscan \
    ros-humble-ros-gz \
    ros-humble-xacro \
    ros-humble-robot-state-publisher \
    ros-humble-joint-state-publisher \
    ros-humble-joint-state-publisher-gui \
    && rm -rf /var/lib/apt/lists/*

# rosdep (necessário para resolver dependências do repo)
RUN rosdep init || true
RUN rosdep update

# Workspace padrão
ENV ROS_WS=/ws
RUN mkdir -p ${ROS_WS}/src
WORKDIR ${ROS_WS}

# Qualidade de vida no bash
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "if [ -f /ws/install/setup.bash ]; then source /ws/install/setup.bash; fi" >> /root/.bashrc

ENV QT_X11_NO_MITSHM=1
CMD ["bash"]
