#!/bin/bash

# 执行程序
run() {
  # 从指定URL下载脚本，执行脚本，并删除脚本文件
  curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/script/$1.sh && bash $1.sh && rm $1.sh -f
}

# 主菜单
menuMain() {
  PS3='>' # 设置菜单提示符
  menu=("更新环境、安装必备程序" "关闭防火墙" "安装程序" "退出") # 定义菜单项
  select fav in "${menu[@]}"; do # 显示菜单并等待用户输入
    case $fav in
    "更新环境、安装必备程序")
      run env
      ;;
    "关闭防火墙")
      run firewall-off
      ;;
    "安装程序")
      PS3='>'
      menu=("安装 DOCKER-CE" "安装 PORTAINER-CE" "安装 PORTAINER-AGENT" "返回")
      select fav in "${menu[@]}"; do
        case $fav in
        "安装 DOCKER-CE")
          run env
          run firewall-off
          run docker-ce-install
          ;;
        "安装 PORTAINER-CE")
          run env
          run firewall-off
          run docker-ce-install
          run portainer-ce-install
          ;;
        "安装 PORTAINER-AGENT")
          run env
          run firewall-off
          run docker-ce-install
          run portainer-agent-install
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
