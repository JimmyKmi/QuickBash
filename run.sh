#!/bin/bash

# 检测网络
echo "正在检测网络..."
ping_google_result=$(ping -c 3 "www.google.com")                             # 发送3个ICMP报文
avg_google_rtt=$(echo "$ping_google_result" | awk -F/ '/^rtt/ { print $5 }') # 解析输出，提取平均延迟

if [ -z "$avg_google_rtt" ]; then
  echo "海外连接失败..."
  # 检测内地网络
  ping_baidu_result=$(ping -c 3 "www.baidu.com")                             # 发送3个ICMP报文
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

# 执行程序
run() {
  # 从指定URL下载脚本，执行脚本，并删除脚本文件
  sudo curl -sSO $GIT_ADDR$1.sh && bash $1.sh && rm $1.sh -f
}

# 主菜单
menuMain() {
  PS3='[]>' # 设置菜单提示符
  menu=(
    "更新环境、安装必备程序"
    "关闭防火墙"
    "DOCKER & PORTAINER"
    "安装驱动"
    "退出")
  select fav in "${menu[@]}"; do # 显示菜单并等待用户输入
    case $fav in
    "更新环境、安装必备程序")
      run env
      ;;
    "关闭防火墙")
      run firewall-off
      ;;
    "DOCKER & PORTAINER")
      PS3='[]>'
      menu=(
        "安装 DOCKER-CE[INSTALL]"
        "安装 PORTAINER-CE[INSTALL]"
        "卸载 PORTAINER-CE[REMOVE]"
        "更新 PORTAINER-CE[UPDATE]"
        "安装 PORTAINER-AGENT[INSTALL]"
        "返回"
      )
      select fav in "${menu[@]}"; do
        case $fav in
        "安装 DOCKER-CE[INSTALL]")
          run environment
          run firewall-off
          run docker-ce-install
          ;;
        "安装 PORTAINER-CE[INSTALL]")
          run environment
          run firewall-off
          run docker-ce-install
          run portainer-ce-install
          ;;
        "卸载 PORTAINER-CE[REMOVE]")
          run portainer-ce-uninstall
          ;;
        "更新 PORTAINER-CE[UPDATE]")
          run portainer-ce-uninstall
          run portainer-ce-install
          ;;
        "安装 PORTAINER-AGENT[INSTALL]")
          run environment
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
    "安装驱动")
      PS3='[]>'
      menu=(
        "NVIDIA GPU FOR UBUNTU(试验性)"
        "返回"
      )
      select fav in "${menu[@]}"; do
        case $fav in
        "NVIDIA GPU FOR DOCKER(试验性)")
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
