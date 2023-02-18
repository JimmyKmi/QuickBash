# QuickBash 懒虫专用回车

语言 / LANGUAGE：[中文](#quickbash-懒虫专用回车) | [English](#quickbash-lazy-mans-enter)

## 简介

QuickBash 是一个面向 Linux 用户的一键安装脚本，旨在帮助用户在 Linux 系统上快速部署常用的开发、运维工具或服务。

QuickBash 包含了一些常用的命令行工具和一些开源应用的安装脚本，用户可以根据自己的需要自由选择需要安装的工具或服务，通过
QuickBash 可以方便地一键安装这些软件，避免了繁琐的手动配置过程，使得 Linux 系统的使用更加便捷。

目前，QuickBash 支持多种 Linux 系统，包括 Alibaba Cloud Linux、CentOS、Ubuntu 等，用户可以根据自己所使用的系统选择相应的版本进行安装。同时，QuickBash
的代码也是开源的，用户可以自由地查看代码、提出建议、提交 PR 等，帮助 QuickBash 不断完善。

如果这个项目帮助到你麻烦点一下 Star，这会使我更有动力去完善它。
遇到问题也可以提Issue，我会定期查看 Issue。更多信息我会在以后放在我的网站上 https://www.lzj.ac.cn/ ，目前网站还在完善。

## 起源

> 一切源于懒
>
这个项目是为了懒虫可以在Linux一键部署一些服务 \
源码源于 JMY 的内部项目 "后端部署技术架构 - Flow" 的工具包，挺好用的所以开源出来，
编写过程也非常曲折，看了不少资料最后总结出一个能用的脚本。

## 如何使用

> 如果服务器在海外 \
> sudo -i && curl -sSO https://gitee.com/jimmykmi/QuickBash/raw/master/run.sh && bash run.sh && rm run.sh -f 
> 
> 如果服务器在内地 \
> sudo -i && curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f 
> 

## 兼容性列表

> 为空则未测试，兼容则会写上测试系统版本，X->不兼容 \
> 注意，不兼容指的是脚本不兼容，不代表程序不兼容 \
> 如果你测试后发现支持，麻烦给我发Issue，我会继续完善这个表

| Alibaba 3  | Alibaba 2 | Anolis 8 | CentOS   | Ubuntu     |
|------------|-----------|----------|----------|------------|
| 3.2104 LTS | --        | --       | 8.5 UEFI | 20.04 UEFI |

---

# QuickBash Lazy Man's Enter

语言 / LANGUAGE：[中文](#quickbash-懒虫专用回车) | [English](#quickbash-lazy-mans-enter)

## Introduction

QuickBash is a one-click installation script for Linux users, designed to help users quickly deploy common development
and operations tools or services on Linux systems.

QuickBash includes some commonly used command-line tools and installation scripts for some open source applications.
Users can freely choose the tools or services they need to install, and can easily install these software with
QuickBash, avoiding tedious manual configuration processes and making Linux system usage more convenient.

Currently, QuickBash supports multiple Linux systems, including Alibaba Cloud Linux, CentOS, Ubuntu, etc. Users can
choose the appropriate version to install according to their own system. In addition, the code of QuickBash is also open
source. Users can freely view the code, make suggestions, submit PRs, and help improve QuickBash.

If this project helps you, please click on the Star button, as it will motivate me to continue improving it. If you
encounter any problems, you can submit an Issue, which I will check regularly. More information will be posted on my
website in the future, at https://www.lzj.ac.cn/. The website is still being improved at the moment.

## Origin

> Everything originates from laziness.
>
This project was created to allow lazy people to deploy some services on Linux with just one click. The source code
comes from JMY's internal project "Backend Deployment Technical Architecture - Flow" tool kit, which is pretty useful,
so I decided to make it open source. The writing process was also very tortuous. After reading a lot of materials, I
finally came up with a script that works.

## How to Use

> sudo -i && curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f

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

| Alibaba 3  | Alibaba 2 | Anolis 8 | CentOS   | Ubuntu     |
|------------|-----------|----------|----------|------------|
| 3.2104 LTS | --        | --       | 8.5 UEFI | 20.04 UEFI |