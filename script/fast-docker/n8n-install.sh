#!/bin/bash
# 快速安装 n8n

# 停止并删除旧的 myn8n 容器
docker stop myn8n
docker rm myn8n
docker volume rm n8n_data

echo "请为 n8n 设置用户名与密码。"

# 提示用户输入用户名和密码
while true; do
  # shellcheck disable=SC2162
  read -p "请输入要创建的用户名: " USERNAME
  if [[ -n "$USERNAME" && ! "$USERNAME" =~ " " ]]; then
    # shellcheck disable=SC2162
    read -p "请输入要创建的密码: " -s PASSWORD
    echo
    # shellcheck disable=SC2162
    read -p "请再次输入密码以确认: " -s PASSWORD2
    echo
    if [[ "$PASSWORD" = "$PASSWORD2" && -n "$PASSWORD" && ! "$PASSWORD" =~ " " ]]; then
      break
    else
      echo "两次输入的密码不一致或密码为空或包含空格，请重新输入。"
    fi
  else
    echo "用户名为空或包含空格，请重新输入。"
  fi
done

# 安装 n8n
docker run -d \
  -p 25678:5678 \
  --name myn8n \
  -v n8n_data:/home/node/.n8n \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER="$USERNAME" \
  -e N8N_BASIC_AUTH_PASSWORD="$PASSWORD" \
  -e NODE_ENV=production \
  n8nio/n8n

# 输出安装成功信息
echo "n8n 安装成功！"
echo "用户名: $USERNAME"
echo "密码: $PASSWORD"
echo "请通过 http://<your_server_ip>:25678 访问 n8n。"
