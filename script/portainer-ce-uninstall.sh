#!/bin/bash

# 检查 Docker 是否已经安装
if ! command -v docker >/dev/null 2>&1 ; then
    echo "Docker 未安装."
fi

# 检查 Portainer 是否已经安装
if ! docker ps --filter name=portainer --format '{{.Names}}' | grep -q "portainer"; then
  echo "Portainer 未安装."
  exit
fi

# 输出警告信息 等待用户确认
read -p "请做好资料备份，确定继续? (y/n) " -t 10 confirm

if [[ $confirm != "y" ]]; then
  # 显示取消信息
  echo "已取消删除 Portainer."
fi

# 停止并删除Portainer容器
docker stop portainer
docker rm portainer

# 删除Portainer镜像
docker rmi portainer/portainer
docker rmi portainer/portainer-ce

# 显示清理完成信息
echo "Portainer 清理完成."