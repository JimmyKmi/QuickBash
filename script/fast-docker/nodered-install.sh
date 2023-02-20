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

# 检查插件是否已安装
if ! docker exec mynodered npm list -g | grep -q node-red-contrib-credentials; then
  echo "正在安装 node-red-contrib-credentials 插件..."
  docker exec mynodered npm install -g node-red-contrib-credentials --location=global
  sudo npm install -g node-red-contrib-credentials
fi

# 设置用户名和密码
echo "请为 Node-RED 设置用户名与密码。"
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

# 生成存储凭证的密钥
KEY=$(docker exec mynodered node -e "console.log(require('crypto').randomBytes(16).toString('hex'));")

# 在容器中创建凭证文件
docker exec mynodered touch /data/credentials.json

# 在凭证文件中添加管理员凭证
docker exec mynodered node -e "console.log(JSON.stringify({admin:{username:'$USERNAME',password:'$PASSWORD'}},null,2));" > credentials.json.tmp
docker exec mynodered node -e "console.log(require('crypto').createCipher('aes192', '$KEY').update(require('fs').readFileSync('/data/credentials.json')).toString('hex'));" | xargs -i{} echo "{}" > credentials.json.tmp.encrypted
docker exec mynodered cat credentials.json.tmp.encrypted >> /data/credentials.json
docker exec mynodered rm credentials.json.tmp credentials.json.tmp.encrypted

# 修改 Node-RED 配置文件，启用凭证文件
docker exec mynodered sed -i -e '/credentialSecret/c\\"credentialSecret": "'"$KEY"'"\' /data/settings.js
docker exec mynodered sed -i -e '/adminAuth/c\\"adminAuth": {\n    "type": "credentials",\n    "users": [\n        {\n            "username": "'"$USERNAME"'",\n            "password": "'"$PASSWORD"'",\n            "permissions": "*"\n        }\n    ]\n}' /data/settings.js

# 重启容器
docker restart mynodered

# 输出安装成功信息
echo "Node-RED 安装成功！"
echo "用户名: $USERNAME"
echo "密码: $PASSWORD"
echo "请通过 http://<your_server_ip>:21800 访问 Node-RED。"