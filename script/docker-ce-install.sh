#!/bin/bash

# 识别包管理器
if command -v dnf &>/dev/null; then
  PACKAGE_HEAD="dnf config-manager"
  PACKAGE_HEAD_SHORT="dnf"
elif command -v yum &>/dev/null; then
  PACKAGE_HEAD="yum-config-manager"
  PACKAGE_HEAD_SHORT="yum"
else
  echo "系统不在兼容列表"
  exit 1
fi

# 添加 docker-ce 的包管理器源
${PACKAGE_HEAD} --add-repo=https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 如果是 Alibaba Cloud Linux 3，安装 dnf-releasever-adapter 插件
if [ -f /etc/alinux-release ]; then
  if grep -q 'Alibaba Cloud Linux release 3' /etc/alinux-release; then
    if command -v dnf &>/dev/null; then
      dnf -y install dnf-plugin-releasever-adapter --repo alinux3-plus
    elif command -v yum &>/dev/null; then
      yum -y install dnf-plugin-releasever-adapter --enablerepo=alinux3-plus
    fi
  fi
fi

# 安装 Docker
${PACKAGE_HEAD_SHORT} -y install docker-ce --nobest

# 启动 Docker
systemctl start docker

# 设置 Docker 开机自启动
systemctl enable docker

# 修改 Docker 配置文件，启用 Docker Hub 国内镜像
cat << EOF > /etc/docker/daemon.json
{
    "registry-mirrors": [
        "http://hub-mirror.c.163.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://registry.docker-cn.com"
    ]
}
EOF

# 重启 Docker
systemctl restart docker

# 检查 Docker 是否安装成功
docker info

