#!/bin/bash
# 快速安装 NGINX-PROXY-MANAGER

# 设置服务名称
VOLUME_NAME="nginx-proxy-manager"
SERVICE_NAME="nginx-proxy-manager"

# 停止并删除旧的容器
docker stop $SERVICE_NAME
docker rm $SERVICE_NAME

# 判断数据卷是否存在
if docker volume ls | grep "$VOLUME_NAME"; then
  # 数据卷存在，询问是否保留数据卷
  read -t 10 -p "是否保留数据卷 $VOLUME_NAME？[Y/n] " KEEP_VOLUME
  if [[ "$KEEP_VOLUME" == "n" || "$KEEP_VOLUME" == "N" ]]; then
    # 不保留数据卷，删除数据卷
    docker volume rm "$VOLUME_NAME"
    echo "已删除数据卷 $VOLUME_NAME。"
  else
    # 保留数据卷，显示提示信息
    echo "已保留数据卷 $VOLUME_NAME。"
  fi
fi

# 安装
docker run -d \
  --name=$SERVICE_NAME \
  -p 8181:8181 \
  -p 8080:8080 \
  -p 4443:4443 \
  -v /docker/appdata/$VOLUME_NAME:/config:rw \
  jlesage/$VOLUME_NAME

echo "$SERVICE_NAME 安装成功，访问 https://<IP Address>:8181 进入后台，默认用户名 admin@example.com，默认密码 changeme"
