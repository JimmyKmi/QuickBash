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

# 安装 Node-RED
docker run -d -p 21800:1880 \
  --name mynodered \
  -v node_red_data:/data \
  nodered/node-red

# 安装 node-red-contrib-credentials 插件
docker exec -u 0 mynodered npm install -g node-red-contrib-credentials --location=global

# 重启 Node-RED 容器，使修改后的配置生效
docker restart mynodered

# 提示用户设置用户名和密码
echo "请为 Node-RED 设置用户名与密码。"

# shellcheck disable=SC2162
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

# shellcheck disable=SC2016
PASSWORD='$2a$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.'

# 把配置文件拷出来
docker cp mynodered:/data/settings.js ./temp_settings.js

# 进入 Node-RED 容器，并修改 settings.js 配置文件
# shellcheck disable=SC1004
# shellcheck disable=SC2016
sed -i 's/\/\/adminAuth: {/adminAuth: {\
    type: "credentials",\
    users: [{\
        username: "'"$USERNAME"'",\
        password: "$2a$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN",\
        permissions: "*"\
    }]\
}/g' ./temp_settings.js

# 把配置文件拷回去
docker cp mynodered:/data/settings.js ./temp_settings.js

# 删除缓存
rm ./temp_settings.js -f

# 设置 Node-RED 的用户名和密码
docker exec mynodered node -e "let settings = require('/data/settings.js'); settings.credentialSecret = '$(openssl rand -base64 18)'; fs.writeFileSync('/data/settings.js', JSON.stringify(settings, null, 2));"

# 重启 Node-RED 容器，使修改后的配置生效
docker restart mynodered

# 输出设置成功信息
echo "Node-RED 用户名与密码设置成功！"
echo "用户名: $USERNAME"
echo "密码: $PASSWORD"
echo "请通过 http://<your_server_ip>:21800 访问 Node-RED。"
