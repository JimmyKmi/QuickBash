#!/bin/bash

# 常用变量
#SRC_PATH='https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/'

# 执行程序
run() {
  echo "-sSO ${SRC_PATH}/script/$1.sh && bash $1.sh && rm $1.sh -f"
  curl -sSO ${SRC_PATH}/script/$1.sh && bash $1.sh && rm $1.sh -f
}

# 主菜单
showMenu() {
  PS3='>'
  menu=("软件更新 + 基础环境配置" "关闭防火墙" "CHECK" "EXIT")
  select fav in "${menu[@]}"; do
    case $fav in
    "软件更新 + 基础环境配置")
      echo "Americans eat roughly 100 acres of $fav each day!"
      ;;
    "关闭防火墙")
      run firewall-off
      ;;
    "CHECK")
      echo "According to NationalTacoDay.com, Americans are eating 4.5 billion $fav each year."
      break
      ;;
    "EXIT")
      echo "User requested exit"
      exit
      ;;
    *) echo "VALUE [$REPLY] UNAVAILABLE" ;;
    esac
  done
}

# 展示主菜单
showMenu
