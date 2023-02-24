#!/bin/bash
# 快速安装 n8n

# 设置服务名称
VOLUME_NAME="n8n_data"
SERVICE_NAME="myn8n"

# 停止并删除旧的 myn8n 容器
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

# 安装 n8n
docker run -d \
  -p 25678:5678 \
  --name $SERVICE_NAME \
  -v n8n_data:/home/node/.n8n \
  -e NODE_ENV=production \
  n8nio/n8n \
  n8n start

# 输出安装成功信息
echo "n8n 安装成功！"
echo "请通过 http://<your_server_ip>:25678 访问 n8n。"
