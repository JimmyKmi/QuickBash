#!/bin/bash
# 快速安装 NODE-RED

echo "注意: nodered 脚本还处于试验阶段，可能存在未知的问题。"
echo "请在确认知晓后继续进行安装。"
while true; do
  read -t 10 -p "您是否确认继续安装？ [Y/n] " yn
  if [[ "$yn" == "y" || "$yn" == "Y" || "$yn" == "" ]]; then
    break
  elif [[ "$yn" == "n" || "$yn" == "N" ]]; then
    echo "您已取消安装。"
    exit 0
  else
    echo "无效的输入，请重新输入。"
  fi
done

# 停止并删除旧的 mynodered 容器
docker stop mynodered
docker rm mynodered

# 设置 Node-RED 的数据卷名称
VOLUME_NAME="node_red_data"

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

# 请为 Node-RED 设置用户名与密码。
echo "请为 Node-RED 设置用户名与密码。"

# 提示用户输入用户名和密码
while true; do
  read -p "请输入要创建的用户名: " USERNAME
  read -p "请输入要创建的密码: " -s PASSWORD
  echo
  read -p "请再次输入密码以确认: " -s PASSWORD2
  echo
  if [ "$PASSWORD" = "$PASSWORD2" ]; then
    break
  else
    echo "两次输入的密码不一致，请重新输入。"
  fi
done

# 安装 Node-RED
docker run -d -p 21800:1880 \
  --name mynodered \
  -v node_red_data:/data \
  -e NODE_RED_ENABLE_PROJECTS=true \
  -e NODE_RED_USERNAME="$USERNAME" \
  -e NODE_RED_PASSWORD="$PASSWORD" \
  nodered/node-red

# 输出安装成功信息
echo "Node-RED 安装成功！"
echo "请通过 http://<your_server_ip>:21800 访问 Node-RED。"
echo "用户名: $USERNAME"
echo "密码: $PASSWORD"
