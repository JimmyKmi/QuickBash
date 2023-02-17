#!/bin/bash

# 检查 Portainer Agent 是否已经安装
if docker ps -a --format "{{.Names}}" | grep -q "^portainer_agent$"; then
  echo "Portainer Agent 已经安装在本机，无需重复安装。"
  exit
else
  echo "开始安装 Portainer Agent。"
fi

# 创建 Portainer Agent 的 Docker 容器
docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent

# 获取服务器的公网 IP 地址
IPADDRESS=$(curl https://api.ipify.org)

# 输出安装成功提示信息
echo "PORTAINER AGENT 安装成功，Environment address: $IPADDRESS:9001。"
