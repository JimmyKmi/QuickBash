#!/bin/bash

# 设置颜色变量
#CLR_BLACK='\033[0;30m' # 黑色
#CLR_RED='\033[0;31m'        # 红色
CLR_GREEN='\033[0;32m' # 绿色
#CLR_YELLOW='\033[0;33m'     # 黄色
#CLR_BLUE='\033[0;34m'       # 蓝色
#CLR_MAGENTA='\033[0;35m'    # 洋红色
#CLR_CYAN='\033[0;36m'       # 青色
#CLR_WHITE='\033[0;37m'      # 白色
CLR_='\033[0m' # 重置颜色
# DEMO
#echo -e "${CLR_BLACK}这是黑色文本${CLR_}"

# 主菜单
showMenu() {
  echo -e "${CLR_GREEN}JIMMY BASH ==${CLR_}"
  echo "============================"
  PS3='Choose your favorite food: '
  menu=("SYSTEM" "DEPLOY" "CHECK" "EXIT")
#  foods=("SYSTEM" "DEPLOY" "CHECK" "EXIT")
  select fav in "${menu[@]}"; do
    case $fav in
    "SYSTEM")
      echo "Americans eat roughly 100 acres of $fav each day!"
      # optionally call a function or run some code here
      ;;
    "DEPLOY")
      echo "$fav is a Vietnamese soup that is commonly mispronounced like go, instead of duh."
      # optionally call a function or run some code here
      ;;
    "CHECK")
      echo "According to NationalTacoDay.com, Americans are eating 4.5 billion $fav each year."
      # optionally call a function or run some code here
      break
      ;;
    "EXIT")
      echo "User requested exit"
      exit
      ;;
    *) echo "输入的值 $REPLY 不可用" ;;
    esac
  done
}

# 展示主菜单
showMenu
