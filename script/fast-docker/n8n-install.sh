#!/bin/bash
# 快速安装 n8n

# 停止并删除旧的 myn8n 容器
docker stop myn8n
docker rm myn8n
docker volume rm n8n_data

# 安装 n8n
docker run -d \
  -p 25678:5678 \
  --name myn8n \
  -v n8n_data:/home/node/.n8n \
  -e NODE_ENV=production \
  n8nio/n8n

# 输出安装成功信息
echo "n8n 安装成功！"
echo "请通过 http://<your_server_ip>:25678 访问 n8n。"
