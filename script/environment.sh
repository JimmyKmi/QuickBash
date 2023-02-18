#!/bin/bash

# 包列表
INSTALL_LIST='install -y conntrack ntpdate ntp ipvsadm ipset iproute2 jq iptables curl sysstat libseccomp wget vim net-tools git'

# shellcheck disable=SC2086
# 根据包管理器匹配指令
if command -v apt-get &>/dev/null; then
  apt-get update
  apt-get ${INSTALL_LIST}
elif command -v dnf &>/dev/null; then
  dnf ${INSTALL_LIST}
elif command -v yum &>/dev/null; then
  yum ${INSTALL_LIST}
else
  # 如果无法检测到系统中使用的包管理器，打印错误消息并退出
  echo "系统不在兼容列表"
  exit 1
fi
