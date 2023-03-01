#!/bin/bash

# 以管理员权限运行
if [ $(id -u) -ne 0 ]; then
  echo "请以管理员权限运行 QuickBash."
  exit 1
fi

# 执行程序
run() {
  # 从指定URL下载脚本，执行脚本，并删除脚本文件
  sudo curl -sSO $GIT_ADDR$1.sh && bash $1.sh && rm $1.sh -f
}

# 执行函数
walk() {
  # 从指定URL下载脚本，执行脚本，并删除脚本文件
  file_name=$1.sh
  sudo curl -sSL $GIT_ADDR/"$file_name" -o /dev/null | bash && bash basename "$file_name" && rm basename "$file_name" -f
}

# 网络检测（并获取 git 源）
walk function/net-check

# 主菜单
menuMain() {
  PS3='[]>' # 设置菜单提示符
  menu=(
    "系统 SYSTEM"
    "容器 DOCKER"
    "驱动 DRIVE"
    "退出")
  select fav in "${menu[@]}"; do # 显示菜单并等待用户输入
    case $fav in
    "系统 SYSTEM")
      PS3='[]>'
      menu=(
        "安装必备程序 ESSENTIAL"
        "校时 CLOCK"
        "关闭防火墙 FIREWALL"
        "返回"
      )
      select fav in "${menu[@]}"; do
        case $fav in
        "安装必备程序 ESSENTIAL")
          run env
          ;;
        "校时 CLOCK")
          run clock
          ;;
        "关闭防火墙 FIREWALL")
          run firewall-off
          ;;
        "返回")
          break
          ;;
        *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
        esac
      done
      ;;
    "容器 DOCKER")
      PS3='[]>'
      menu=(
        "安装 DOCKER-CE[INSTALL]"
        "安装UI PORTAINER-CE[INSTALL]"
        "卸载UI PORTAINER-CE[REMOVE]"
        "更新UI PORTAINER-CE[UPDATE]"
        "安装UI子节点 PORTAINER-AGENT[INSTALL]"
        "安装服务 FAST-DOCKER"
        "返回"
      )
      select fav in "${menu[@]}"; do
        case $fav in
        "安装 DOCKER-CE[INSTALL]")
          run clock
          run environment
          run firewall-off
          run docker-ce-install
          ;;
        "安装UI PORTAINER-CE[INSTALL]")
          run clock
          run environment
          run firewall-off
          run docker-ce-install
          run portainer-ce-install
          ;;
        "卸载UI PORTAINER-CE[REMOVE]")
          run portainer-ce-uninstall
          ;;
        "更新UI PORTAINER-CE[UPDATE]")
          run portainer-ce-uninstall
          run portainer-ce-install
          ;;
        "安装UI子节点 PORTAINER-AGENT[INSTALL]")
          run clock
          run environment
          run firewall-off
          run docker-ce-install
          run portainer-agent-install
          ;;
        "安装服务 FAST-DOCKER")
          run fast-docker
          ;;
        "返回")
          break
          ;;
        *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
        esac
      done
      ;;
    "驱动 DRIVE")
      PS3='[]>'
      menu=(
        "NVIDIA GPU FOR DOCKER 试验性"
        "返回"
      )
      select fav in "${menu[@]}"; do
        case $fav in
        "NVIDIA GPU FOR DOCKER 试验性")
          run gpu-nvidia-for-docker
          ;;
        "返回")
          break
          ;;
        *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
        esac
      done
      ;;
    "退出")
      exit
      ;;
    *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
    esac
  done
}

# 展示主菜单
menuMain
