#!/bin/bash

# 检查 Portainer Agent 是否已经安装
if docker ps -a --format "{{.Names}}" | grep -q "^portainer_agent$"; then
  echo "Portainer Agent 已经安装在本机，无需重复安装。"
  exit
else
  echo "开始安装 Portainer Agent。"
fi

# 提示用户输入 AGENT_SECRET
while true; do
  echo "AGENT_SECRET 是 Portainer 与 Portainer Agent 相互认证的密钥，将会作为 portainer agent 环境变量启动。"
  # shellcheck disable=SC2162
  read -p "请输入 AGENT_SECRET ：" AGENT_SECRET
  if [[ -n "${AGENT_SECRET}" && ! "${AGENT_SECRET}" =~ " " ]]; then
    break
  else
    echo "输入内容至少包含一个字符串，且不能含空格"
  fi
done

echo "正在创建容器"

# 创建 Portainer Agent 的 Docker 容器
docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes -e AGENT_SECRET="${AGENT_SECRET}" portainer/agent

# 获取服务器的公网 IP 地址
IPADDRESS=$(curl https://api.ipify.org)

# 输出安装成功提示信息
echo "PORTAINER AGENT 安装成功，Environment address: $IPADDRESS:9001。"
