#!/bin/bash

# 检查是否为管理员权限的用户
if [ "$(id -u)" != "0" ]; then
    echo "请以管理员权限运行 =。=!"
    exit 1
fi
# 获取管理员权限
sudo -i

# 退出管理员权限
exit