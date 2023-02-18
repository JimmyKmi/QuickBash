#!/bin/bash
# 为 Docker 添加 Nvidia GPU

echo "正在安装 NVIDIA FOR DOCKER 驱动"

# 获取发行版信息，以在 nvidia-docker 官方网站选择正确的仓库
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

# 添加 nvidia-docker apt-key，信任官方源
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo tee /usr/share/keyrings/nvidia-docker.gpg > /dev/null

# 添加 nvidia-docker apt 源到 /etc/apt/sources.list.d/
# 使用清华镜像加速下载
echo "添加 nvidia-docker apt 源到 /etc/apt/sources.list.d/"
curl -s -L "https://mirrors.tuna.tsinghua.edu.cn/nvidia-docker/$distribution/nvidia-docker.list" | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# 更新 apt 源
sudo apt-get update

# 安装 NVIDIA Container Toolkit
sudo apt-get install -y nvidia-docker2

# 重启 Docker 守护进程
echo "重启 Docker 守护进程"
sudo systemctl restart docker

# 确认 NVIDIA Container Toolkit 是否安装成功
echo "确认 NVIDIA Container Toolkit 是否安装成功"
sudo docker run -it --gpus all nvidia/cuda:12.0.1-runtime-ubuntu22.04 nvidia-smi
