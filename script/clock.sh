#!/bin/bash
# 校时

# 检查是否已经安装了 ntpdate 命令
if command -v ntpdate &>/dev/null; then
  echo "正在使用 ntpdate 命令同步系统时间"
  # Ubuntu/Debian
  if [ -f /etc/debian_version ]; then
    sudo ntpdate ntp.ubuntu.com
  # CentOS/Fedora
  elif [ -f /etc/redhat-release ]; then
    sudo ntpdate ntp.ntsc.ac.cn
  else
    echo "不支持的 Linux 发行版"
    exit 1
  fi
# 检查是否已经安装了 timedatectl 命令
elif command -v timedatectl &>/dev/null; then
  echo "正在使用 timedatectl 命令同步系统时间"
  sudo timedatectl set-ntp true
else
  echo "正在安装 ntpdate 和 systemd-timesyncd 命令"
  # Ubuntu/Debian
  if [ -f /etc/debian_version ]; then
    sudo apt-get update
    sudo apt-get install -y ntpdate systemd-timesyncd
  # CentOS/Fedora
  elif [ -f /etc/redhat-release ]; then
    sudo yum install -y ntpdate systemd-timesyncd
  else
    echo "不支持的 Linux 发行版"
    exit 1
  fi
  # 重新检查并同步时间
  $0
  exit 0
fi

echo "系统时间已经同步"
