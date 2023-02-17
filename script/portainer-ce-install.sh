#!/bin/bash

# 检查 Portainer 是否已经安装
if docker ps -a --format "{{.Names}}" | grep -q "^portainer$"; then
  echo "Portainer 已经安装在本机，无需重复安装。"
  exit
else
  echo "开始安装 Portainer。"
fi

# 创建 Docker volume
docker volume create portainer_data

# 启动 Portainer Community Edition，9443 为对外端口
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# 获取服务器的公网 IP 地址
IPADDRESS=$(curl https://api.ipify.org)

# 输出安装成功提示信息
echo "PORTAINER 安装成功，请访问 https://$IPADDRESS:9443/ 进行初始化配置。如果长时间未配置，则需要重启容器才能进入配置页面。如果 IP 地址不正确，请手动输入正确的 IP 地址访问。"