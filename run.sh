#!/bin/bash

# 设置颜色变量
CLR_BLACK='\033[0;30m' # 黑色
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

# 菜单
echo -e "${CLR_GREEN}JIMMY BASH ==${CLR_}"
echo "============================"
echo "请选择需要的操作："
echo "1. 容器相关"
echo "2. 选项2"
echo "3. 选项3"
echo "4. 退出"

# 读取用户的选择
read -p "输入选项号码: " choice

# 根据用户的选择执行相应的操作
case $choice in
1)
  echo "您选择了选项1"
  # 在这里添加选项1的操作
  ;;
2)
  echo "您选择了选项2"
  # 在这里添加选项2的操作
  ;;
3)
  echo "您选择了选项3"
  # 在这里添加选项3的操作
  ;;
4)
  echo "感谢使用，再见！"
  exit 0
  ;;
*)
  echo "无效的选项，请重新选择。"
  ;;
esac