# QuickBash 懒虫专用回车

> 该项目仍在开发阶段，使用前请仔细阅读脚本

## 起源

> 一切源于懒
>
这个项目是为了懒虫可以在Linux一键部署一些服务 \
源码源于 JMY 的内部项目 "后端部署技术架构 - Flow" 的工具包，挺好用的所以开源出来，
编写过程也非常曲折，看了不少资料最后总结出一个能用的脚本。

## 注意事项

如果这个项目帮助到你麻烦点一下 Star，这会使我更有动力去完善它。
遇到问题也可以提Issue，我会定期查看 Issue。更多信息我会在以后放在我的网站上 https://www.lzj.ac.cn/ ，目前网站还在完善。

## 兼容性列表

> 为空则未测试，兼容则会写上测试系统版本，X->不兼容

| \            | Alibaba 3      | Alibaba 2 | Anolis 8 | CentOS | Ubuntu |
|--------------|----------------|-----------|----------|--------|--------|
| SYSTEM       |
| firewall-off | 3.2104 LTS x64 | --        | --       | --     | --     |
|              |
| DEPLOY       |
| docker       | 3.2104 LTS x64 | --        | --       | --     | --     |
| portainer    | 3.2104 LTS x64 | --        | --       | --     | --     |
|              |
| FAST-DEPLOY  |
| firewall-off | 3.2104 LTS x64 | --        | --       | --     | --     |

## 如何使用

> curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f