#!/bin/bash

# 检查 Docker 是否已经安装
if ! command -v docker >/dev/null 2>&1 ; then
    echo "Docker 未安装."
fi


# 检查 Portainer 是否已经安装
if docker ps -a --format "{{.Names}}" | grep -q "^portainer$"; then
  echo "Portainer 已经安装在本机，无需重复安装。"
  exit
else
  echo "开始安装 Portainer。"
fi

# 提示用户输入 AGENT_SECRET
while true; do
  echo "AGENT_SECRET 是 Portainer 与 Portainer Agent 相互认证的密钥，将会作为 portainer 环境变量启动。"
  # shellcheck disable=SC2162
  read -p "请输入 AGENT_SECRET ：" AGENT_SECRET
  if [[ -n "${AGENT_SECRET}" && ! "${AGENT_SECRET}" =~ " " ]]; then
    break
  else
    echo "输入内容至少包含一个字符串，且不能含空格"
  fi
done

echo "正在创建容器"

# 创建 Docker volume
docker volume create portainer_data

# 创建 Docker
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -e AGENT_SECRET="${AGENT_SECRET}" portainer/portainer-ce:latest

# 获取服务器的公网 IP 地址
IPADDRESS=$(curl https://api.ipify.org)

# 输出安装成功提示信息
echo "PORTAINER 安装成功，请访问 https://$IPADDRESS:9443/ 进行初始化配置。如果长时间未配置，则需要重启容器才能进入配置页面。如果 IP 地址不正确，请手动输入正确的 IP 地址访问。"