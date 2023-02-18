#!/bin/bash
# 快速安装 NODE-RED

echo "请为 Node-RED 设置用户名与密码。"

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

# 安装 Node-RED
docker run -d \
  -p 21800:1880 \
  --name mynodered \
  -v node_red_data:/data \
  -e NODE_RED_ENABLE_PROJECTS=true \
  -e NODE_RED_USERNAME="$USERNAME" \
  -e NODE_RED_PASSWORD="$PASSWORD" \
  nodered/node-red

# 输出安装成功信息
echo "Node-RED 安装成功！"
echo "用户名: $USERNAME"
echo "密码: $PASSWORD"
echo "请通过 http://<your_server_ip>:21800 访问 Node-RED。"
