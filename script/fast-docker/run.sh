#!/bin/bash

# 检查是否以管理员权限运行
# shellcheck disable=SC2046
if [ $(id -u) -ne 0 ]; then
  echo "请以管理员权限运行此脚本。"
  exit 1
fi

# 检测网络
echo "正在检测网络..."
ping_google_result=$(ping -c 3 -W 1 "www.google.com")                             # 发送3个ICMP报文
avg_google_rtt=$(echo "$ping_google_result" | awk -F/ '/^rtt/ { print $5 }') # 解析输出，提取平均延迟

if [ -z "$avg_google_rtt" ]; then
  echo "海外连接失败..."
  # 检测内地网络
  ping_baidu_result=$(ping -c 3 -W 1 "www.baidu.com")                             # 发送3个ICMP报文
  avg_baidu_rtt=$(echo "$ping_baidu_result" | awk -F/ '/^rtt/ { print $5 }') # 解析输出，提取平均延迟

  if [ -z "$avg_baidu_rtt" ]; then
    echo "内地连接失败..."
    echo "请检查网络状况."
    exit
  else
    echo "内地延迟: $avg_baidu_rtt ms，使用 Gitee 源."
    GIT_ADDR="https://gitee.com/jimmykmi/QuickBash/raw/master/script/"
  fi
else
  echo "海外延迟: $avg_google_rtt ms，使用 GitHub 源."
  GIT_ADDR="https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/script/"
fi

# 过滤掉没装 Docker 的小可爱
if ! command -v docker >/dev/null 2>&1 ; then
    echo "Docker 未安装."
    exit
fi

# 执行程序
run() {
  # 从指定URL下载脚本，执行脚本，并删除脚本文件
  sudo curl -sSO $GIT_ADDR$1.sh && bash $1.sh && rm $1.sh -f
}

# 主菜单
menuMain() {
  PS3='[]>' # 设置菜单提示符
  menu=(
    "安装 NODE-RED"
    "返回")
  select fav in "${menu[@]}"; do # 显示菜单并等待用户输入
    case $fav in
    "NODE-RED")
      run fast-docker/nodered-install
      ;;
    "返回")
      exit
      ;;
    *) echo "VALUE [$REPLY] UNAVAILABLE" ;; # 处理非法输入
    esac
  done
}

# 展示主菜单
menuMain
