#!/bin/bash
# 快速安装 NODE-RED

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
#PASSWORD='$2a$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.'
# 检查 Node.js 是否已安装
if ! command -v node >/dev/null; then
  echo "Node.js is not installed. Installing it now..."

  # 检查系统上使用的包管理器
  if command -v apt-get >/dev/null; then
    # Debian/Ubuntu
    sudo apt-get install nodejs -y
  elif command -v yum >/dev/null; then
    # CentOS/Fedora
    sudo yum install nodejs -y
  else
    # 其他发行版
    echo "系统不在支持列表."
    exit 1
  fi
fi

# 检查 NPM 是否已安装
if ! command -v npm >/dev/null; then
  echo "NPM is not installed. Installing it now..."
  # 检查系统上使用的包管理器
  if command -v apt-get >/dev/null; then
    # Debian/Ubuntu
    sudo apt-get install npm -y
  elif command -v yum >/dev/null; then
    # CentOS/Fedora
    sudo yum install npm -y
  else
    # 其他发行版
    echo "系统不在支持列表."
    exit 1
  fi
fi

# 显示 Node.js 和 NPM 的版本信息
node -v
npm -v

npm install bcryptjs
PASSWORD=$(node -e "console.log(require('bcryptjs').hashSync('password', 8));")
echo $PASSWORD

# 进入 Node-RED 容器，并修改 settings.js 配置文件
# shellcheck disable=SC1004
# shellcheck disable=SC2016
sed -i 's/\/\/adminAuth: {/adminAuth: {\
        type: "credentials",\
        users: [{\
            username: "'"$USERNAME"'",\
            password: "'"$PASSWORD"'",\
            permissions: "*"\
        }]\
    },/g' /var/lib/docker/volumes/node_red_data/_data/settings.js

# 重启 Node-RED 容器，使修改后的配置生效
docker restart mynodered

# 输出设置成功信息
echo "Node-RED 用户名与密码设置成功！"
echo "用户名: $USERNAME"
echo "密码: $PASSWORD"
echo "请通过 http://<your_server_ip>:21800 访问 Node-RED。"
