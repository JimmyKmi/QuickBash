#!/bin/bash

# 以管理员权限运行
if [ $(id -u) -ne 0 ]; then
  echo "请以管理员权限运行 QuickBash."
  exit 1
fi

# 检测网络
echo "正在检测网络..."
{
  if curl --connect-timeout 10 -sf http://www.gstatic.com/generate_204 >/dev/null; then
    echo "网络可达."
  else
    echo "网络不可达..."
    echo "请检测网络."
    exit 1
  fi
} &
{
  if curl --connect-timeout 3 -sf http://www.google.com/ >/dev/null; then
    echo "不存在干扰，使用 GitHub 源."
    export GIT_ADDRESS="https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/"
    export GIT_ADDR="https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/script/"
  else
    echo "可能存在干扰，使用 Gitee 源."
    export GIT_ADDRESS="https://gitee.com/jimmykmi/QuickBash/raw/master/"
    export GIT_ADDR="https://gitee.com/jimmykmi/QuickBash/raw/master/script/"
  fi
}

# 执行函数
walk() {
  # 从指定URL下载脚本，执行脚本，并删除脚本文件
  file_path=$1.sh
  file_local_name=${file_path//\//_}
  sudo curl -sSo "$file_local_name" $GIT_ADDRESS"$file_path" && chmod +x "$file_local_name" && bash "$file_local_name" && rm "$file_local_name" -f
}

# 执行程序 %即将弃用
run() {
  # 从指定URL下载脚本，执行脚本，并删除脚本文件
  sudo curl -sSO $GIT_ADDR$1.sh && bash $1.sh && rm $1.sh -f
}

walk menu/system

## 主菜单
#menuMain() {
#  PS3='[]>' # 设置菜单提示符
#  menu=(
#    "系统 SYSTEM"
#    "容器 DOCKER"
#    "驱动 DRIVE"
#    "退出")
#  select fav in "${menu[@]}"; do # 显示菜单并等待用户输入
#    case $fav in
#    "系统 SYSTEM")
#      PS3='[]>'
#      menu=(
#        "安装必备程序 ESSENTIAL"
#        "校时 CLOCK"
#        "关闭防火墙 FIREWALL"
#        "返回"
#      )
#      select fav in "${menu[@]}"; do
#        case $fav in
#        "安装必备程序 ESSENTIAL")
#          run env
#          ;;
#        "校时 CLOCK")
#          run clock
#          ;;
#        "关闭防火墙 FIREWALL")
#          run firewall-off
#          ;;
#        "返回")
#          break
#          ;;
#        *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
#        esac
#      done
#      ;;
#    "容器 DOCKER")
#      PS3='[]>'
#      menu=(
#        "安装 DOCKER-CE[INSTALL]"
#        "安装UI PORTAINER-CE[INSTALL]"
#        "卸载UI PORTAINER-CE[REMOVE]"
#        "更新UI PORTAINER-CE[UPDATE]"
#        "安装UI子节点 PORTAINER-AGENT[INSTALL]"
#        "安装服务 FAST-DOCKER"
#        "返回"
#      )
#      select fav in "${menu[@]}"; do
#        case $fav in
#        "安装 DOCKER-CE[INSTALL]")
#          run clock
#          run environment
#          run firewall-off
#          run docker-ce-install
#          ;;
#        "安装UI PORTAINER-CE[INSTALL]")
#          run clock
#          run environment
#          run firewall-off
#          run docker-ce-install
#          run portainer-ce-install
#          ;;
#        "卸载UI PORTAINER-CE[REMOVE]")
#          run portainer-ce-uninstall
#          ;;
#        "更新UI PORTAINER-CE[UPDATE]")
#          run portainer-ce-uninstall
#          run portainer-ce-install
#          ;;
#        "安装UI子节点 PORTAINER-AGENT[INSTALL]")
#          run clock
#          run environment
#          run firewall-off
#          run docker-ce-install
#          run portainer-agent-install
#          ;;
#        "安装服务 FAST-DOCKER")
#          run fast-docker
#          ;;
#        "返回")
#          break
#          ;;
#        *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
#        esac
#      done
#      ;;
#    "驱动 DRIVE")
#      PS3='[]>'
#      menu=(
#        "NVIDIA GPU FOR DOCKER 试验性"
#        "返回"
#      )
#      select fav in "${menu[@]}"; do
#        case $fav in
#        "NVIDIA GPU FOR DOCKER 试验性")
#          run gpu-nvidia-for-docker
#          ;;
#        "返回")
#          break
#          ;;
#        *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
#        esac
#      done
#      ;;
#    "退出")
#      exit
#      ;;
#    *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
#    esac
#  done
#}
#
## 展示主菜单
#menuMain
