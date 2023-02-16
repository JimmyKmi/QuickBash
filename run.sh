#!/bin/bash

# 执行程序
run() {
  echo "路径::https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/script/$1.sh"
  curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/script/$1.sh && bash $1.sh && rm $1.sh -f
}

# 主菜单
menuMain() {
  PS3='>'
  menu=("更新环境、安装必备程序" "关闭防火墙" "安装程序" "退出")
  select fav in "${menu[@]}"; do
    case $fav in
    "更新环境、安装必备程序")
      run env
      ;;
    "关闭防火墙")
      run firewall-off
      ;;
    "安装程序")
      PS3='安装程序>'
      menu=("安装 DOCKER" "安装 PORTAINER" "返回")
      select fav in "${menu[@]}"; do
        case $fav in
        "安装 DOCKER-CE")
          run env
          run firewall-off
          run docker-ce-install
          ;;
        "安装 DOCKER-CE & PORTAINER-CE")
          run env
          run firewall-off
          run docker-ce-install
          run portainer-ce-install
          ;;
        "返回")
          break
          ;;
        *) echo "VALUE [$REPLY] UNAVAILABLE" ;;
        esac
      done
      ;;
    "退出")
      exit
      ;;
    *) echo "VALUE [$REPLY] UNAVAILABLE" ;;
    esac
  done
}

# 展示主菜单
menuMain
