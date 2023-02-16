#!/bin/bash

# 关闭所有防火墙
if [ -f /etc/lsb-release ]; then
  # Ubuntu
  sudo ufw disable
  sudo systemctl stop ufw
  sudo systemctl disable ufw
elif [ -f /etc/redhat-release ]; then
  # RHEL
  if grep "release 7" /etc/redhat-release >/dev/null; then
    sudo systemctl stop firewalld
    sudo systemctl disable firewalld
    sudo systemctl mask --now firewalld
  else
    sudo service iptables stop
    sudo chkconfig iptables off
    sudo service ip6tables stop
    sudo chkconfig ip6tables off
  fi
else
  echo "系统不在兼容列表"
  exit 1
fi

echo "防火墙已禁用"
echo "关闭防火墙后系统可能会遭到网络攻击，如果使用云服务器请设置安全组。"