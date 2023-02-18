#!/bin/bash

# 防止重复安装
if command -v docker &>/dev/null; then
  echo "Docker 已经安装在本机，无需重复安装。"
  exit
else
  echo "开始安装 Docker。"
fi

# 识别包管理器
if command -v dnf &>/dev/null; then
  PACKAGE_HEAD="dnf config-manager"
  PACKAGE_HEAD_SHORT="dnf"
  PACKAGE_TAG="--nobest"
elif command -v yum &>/dev/null; then
  PACKAGE_HEAD="yum-config-manager"
  PACKAGE_HEAD_SHORT="yum"
  PACKAGE_TAG="--nobest"
elif command -v apt-get &>/dev/null; then
  PACKAGE_HEAD="add-apt-repository"
  PACKAGE_HEAD_SHORT="apt-get"
  PACKAGE_TAG=""
else
  echo "系统不在兼容列表"
  exit 1
fi

# 添加 docker-ce 的包管理器源
echo "正在添加 docker-ce 的包管理器源..."
${PACKAGE_HEAD} --add-repo=https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 如果是 Alibaba Cloud Linux 3，安装 dnf-releasever-adapter 插件
if [ -f /etc/alinux-release ]; then
  if grep -q 'Alibaba Cloud Linux release 3' /etc/alinux-release; then
    echo "检测到 Alibaba Cloud Linux，正在安装 dnf-releasever-adapter 插件..."
    if command -v dnf &>/dev/null; then
      dnf -y install dnf-plugin-releasever-adapter --repo alinux3-plus
    elif command -v yum &>/dev/null; then
      yum -y install dnf-plugin-releasever-adapter --enablerepo=alinux3-plus
    fi
  fi
fi

# 安装 Docker
echo "正在安装 Docker..."
${PACKAGE_HEAD_SHORT} -y install docker-ce "${PACKAGE_TAG}"

# 启动 Docker
echo "正在启动 Docker..."
systemctl start docker

# 设置 Docker 开机自启动
echo "正在设置 Docker 开机自启动..."
systemctl enable docker

# 修改 Docker 配置文件，启用 Docker Hub 国内镜像
cat <<EOF >/etc/docker/daemon.json
{
  "registry-mirrors": [
    "https://docker.mirrors.ustc.edu.cn",
    "https://registry.docker-cn.com",
    "https://dockerhub.azk8s.cn",
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}
EOF

# 重启 Docker
echo "正在重启 Docker..."
systemctl restart docker

# 检查 Docker 是否安装成功
echo "正在检查 Docker 是否安装成功..."
docker info
