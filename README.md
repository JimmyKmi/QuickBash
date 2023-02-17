# QuickBash 懒虫专用回车

语言 / LANGUAGE：[中文](#quickbash-懒虫专用回车) | [English](#quickbash-lazy-mans-enter-key)

## 起源

> 一切源于懒
>
这个项目是为了懒虫可以在Linux一键部署一些服务 \
源码源于 JMY 的内部项目 "后端部署技术架构 - Flow" 的工具包，挺好用的所以开源出来，
编写过程也非常曲折，看了不少资料最后总结出一个能用的脚本。

## 注意事项

如果这个项目帮助到你麻烦点一下 Star，这会使我更有动力去完善它。
遇到问题也可以提Issue，我会定期查看 Issue。更多信息我会在以后放在我的网站上 https://www.lzj.ac.cn/ ，目前网站还在完善。

## 如何使用

> curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f

## 兼容性列表

> 为空则未测试，兼容则会写上测试系统版本，X->不兼容 \
> 注意，不兼容指的是脚本不兼容，不代表程序不兼容 \
> 如果你测试后发现支持，麻烦给我发Issue，我会继续完善这个表

| \            | Alibaba 3  | Alibaba 2 | Anolis 8 | CentOS   | Ubuntu     |
|--------------|------------|-----------|----------|----------|------------|
| SYSTEM       |
| firewall-off | 3.2104 LTS | --        | --       | 8.5 UEFI | 20.04 UEFI |
|              |
| DEPLOY       |
| docker       | 3.2104 LTS | --        | --       | 8.5 UEFI | -          |
| portainer    | 3.2104 LTS | --        | --       | 8.5 UEFI | -          |

---

# QuickBash Lazy Man's Enter Key

语言 / LANGUAGE：[中文](#quickbash-懒虫专用回车) | [English](#quickbash-lazy-mans-enter-key)

## Origin

> Everything originates from laziness.
>
This project was created to allow lazy people to deploy some services on Linux with just one click. The source code
comes from JMY's internal project "Backend Deployment Technical Architecture - Flow" tool kit, which is pretty useful,
so I decided to make it open source. The writing process was also very tortuous. After reading a lot of materials, I
finally came up with a script that works.

## Notes

If this project helps you, please click on the Star button, as it will motivate me to continue improving it. If you
encounter any problems, you can submit an Issue, which I will check regularly. More information will be posted on my
website in the future, at https://www.lzj.ac.cn/. The website is still being improved at the moment.

## How to Use

> curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f

## Compatibility List

> If the list is empty, it means that the script has not been tested.
>
> If the system version is listed, it means that the script has been tested and is compatible.
> If the letter X appears, it means that the script is not compatible with that system.
>
> Please note that "not compatible" means that the script is not compatible, not that the program is not compatible.
>
> If you find that the script works on a system that is not listed here, please submit an Issue, and I will continue to
> improve this table.

| \            | Alibaba 3  | Alibaba 2 | Anolis 8 | CentOS   | Ubuntu     |
|--------------|------------|-----------|----------|----------|------------|
| SYSTEM       |
| firewall-off | 3.2104 LTS | --        | --       | 8.5 UEFI | 20.04 UEFI |
|              |
| DEPLOY       |
| docker       | 3.2104 LTS | --        | --       | 8.5 UEFI | -          |
| portainer    | 3.2104 LTS | --        | --       | 8.5 UEFI | -          |