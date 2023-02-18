#!/bin/bash

# 确认添加快捷方式
echo -n "确认要添加 QuickBash 快捷方式吗？(y/n): "
read confirm

if [ "$confirm" != "y" ]; then
  echo "快捷方式未添加."
  exit
fi

echo "正在检测网络..."
ping_google_result=$(ping -c 3 -W 1 "www.google.com")                        # 发送3个ICMP报文
avg_google_rtt=$(echo "$ping_google_result" | awk -F/ '/^rtt/ { print $5 }') # 解析输出，提取平均延迟

if [ -z "$avg_google_rtt" ]; then
  echo "海外连接失败..."
  # 检测内地网络
  ping_baidu_result=$(ping -c 3 -W 1 "www.baidu.com")                        # 发送3个ICMP报文
  avg_baidu_rtt=$(echo "$ping_baidu_result" | awk -F/ '/^rtt/ { print $5 }') # 解析输出，提取平均延迟

  if [ -z "$avg_baidu_rtt" ]; then
    echo "内地连接失败..."
    echo "请检查网络状况."
    exit
  else
    echo "内地延迟: $avg_baidu_rtt ms，使用 Gitee 源."
    sudo curl -sSO https://gitee.com/jimmykmi/QuickBash/raw/master/run.sh && bash run.sh && rm run.sh -f
    echo "设置更新源为 gitee."
  fi
else
  echo "海外延迟: $avg_google_rtt ms，使用 GitHub 源."
  sudo curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f
  echo "设置更新源为 github."
fi

echo "快捷方式已添加，需要启动 quickbash 时只需要输入 quickbash 即可"
