#!/bin/bash

# 检测网络
echo "正在检测网络..."

{
  if curl --connect-timeout 10 -sf http://www.gstatic.com/generate_204 >/dev/null; then
    echo "网络可达."
  else
    echo "网络不可达..."
    echo "请检测网络."
    exit 1
  fi
} &
{
  if curl --connect-timeout 3 -sf http://www.google.com/ >/dev/null; then
    echo "不存在干扰，使用 GitHub 源."
    export GIT_ADDRESS="https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/script/"
    export GIT_ADDR="https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/script/"
  else
    echo "可能存在干扰，使用 Gitee 源."
    export GIT_ADDRESS="https://gitee.com/jimmykmi/QuickBash/raw/master/"
    export GIT_ADDR="https://gitee.com/jimmykmi/QuickBash/raw/master/script/"
  fi
}