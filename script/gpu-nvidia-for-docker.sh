#!/bin/bash
# 为 Docker 添加 Nvidia GPU

echo "正在安装 NVIDIA FOR DOCKER 驱动"

# 卸载驱动
sudo apt-get purge nvidia*

# 获取内核版本
nvidia_version=$(cat /proc/driver/nvidia/version | grep "Kernel Module" | cut -d " " -f 9 | awk -F "." '{print $1}')

# 安装驱动
sudo apt-get install -y nvidia-driver-$nvidia_version nvidia-settings nvidia-prime

nvidia-smi

# 获取发行版信息，以在 nvidia-docker 官方网站选择正确的仓库
distribution=$(
  . /etc/os-release
  echo $ID$VERSION_ID
)

# 添加 nvidia-docker apt-key，信任官方源
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo tee /usr/share/keyrings/nvidia-docker.gpg >/dev/null

# 添加 nvidia-docker apt 源到 /etc/apt/sources.list.d/
echo "添加 nvidia-docker apt 源到 /etc/apt/sources.list.d/"
curl -s -L "https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list" |
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# 更新 apt 源，安装 NVIDIA Container Toolkit
sudo sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

# 重启 Docker 守护进程
echo "重启 Docker 守护进程"
sudo systemctl restart docker

# 确认 NVIDIA Container Toolkit 是否安装成功
echo "确认 NVIDIA Container Toolkit 是否安装成功"
nvidia-smi -L
