#!/bin/bash

# 确认添加快捷方式
echo -n "确认要添加 QuickBash 快捷方式吗？(y/n): "
read confirm

if [ "$confirm" != "y" ]; then
  echo "快捷方式未添加."
  exit
fi

# 判断 GIT_ADDR
if [ "$GIT_ADDR" = "https://gitee.com/jimmykmi/QuickBash/raw/master/script/" ]; then
  sudo curl -sSO https://gitee.com/jimmykmi/QuickBash/raw/master/run.sh && bash run.sh && rm run.sh -f
  echo "设置默认源为 gitee."
else
  sudo curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f
  echo "设置默认源为 github."
fi

echo "快捷方式已添加，需要启动 quickbash 时只需要输入 quickbash 即可"