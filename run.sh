#!/bin/bash

# 常用变量
SRC_PATH='https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/'

# 主菜单
showMenu() {
  echo "=============MENU=============="
  PS3='>'
  menu=("SYSTEM" "DEPLOY" "CHECK" "EXIT")
#  foods=("SYSTEM" "DEPLOY" "CHECK" "EXIT")
  select fav in "${menu[@]}"; do
    case $fav in
    "SYSTEM")
      echo "Americans eat roughly 100 acres of $fav each day!"
      ;;
    "DEPLOY")
      echo "$fav is a Vietnamese soup that is commonly mispronounced like go, instead of duh."
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
