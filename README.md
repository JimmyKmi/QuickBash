# QuickBash 快速脚本

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
### 使用前、提交 ISSUE 前请务必阅读兼容性列表、注意事项

> 
> 如果服务器在内地 \
> sudo curl -sSO https://gitee.com/jimmykmi/QuickBash/raw/master/run.sh && bash run.sh && rm run.sh -f
>
> 如果服务器在海外 \
> sudo curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f
>

## 兼容性列表

> 有这一列就代表理论上兼容，为空则未测试，兼容则会写上测试系统版本，X代表不兼容 \
> 注意，不兼容指的是脚本不兼容，不代表程序不兼容 \
> 如果你测试后发现支持，麻烦给我发Issue，我会继续完善这个表

| /               | Alibaba 3  | Alibaba 2 | Anolis 8 | CentOS   | Ubuntu     |
|-----------------|------------|-----------|----------|----------|------------|
| 默认              | 3.2104 LTS | --        | --       | 8.5 UEFI | 20.04 UEFI |
| NVIDIA-GPUS[试验] | --         | --        | --       | --       | 20.04 UEFI |

## 注意事项

### 在生产环境中使用
作者并不想也不会对你的生产环境担责，使用前请根据下列步骤规避可能的风险。
1. 作者会在自己的业务使用此脚本，但并不意味着这对你来说绝对没问题，毕竟谁会知道你的系统以前是否有残留的屎山呢？
2. 建议先 fork 后调用你自己的分支。也可以避免了因为脚本更新而你手快导致安装错东西的情况。
3. 使用前请仔细阅读脚本所执行的内容。
4. 此脚本的设计是在虚拟化场景+统一网络管理场景设计的（本地带防火墙机房、阿里云、腾讯云、华为云...），会默认关闭系统中的防火墙，使用统一安全组或出入口防火墙做策略，方便管理。
如果你需要使用系统的防火墙，请 fork 后自行删除 firewall-off.sh 或修改里面的内容。

### 兼容适配
1. 如果你的系统是 群晖、HomeAssistant、OpenWrt、iKuai 等一些奇奇怪怪的系统，请不要在这类系统的生产环境中使用此脚本。但是你可以参考里面的指令进行输入。
2. 后续可能会对群晖做兼容，如果我哪一天头脑发热或者有人给我一个比较好的方案。
3. 这个脚本可以兼容一些奇奇怪怪的设备树莓派的兼容是试验性的，如果你还要在什么奇奇怪怪的设备上运行欢迎寄给我研究一下（doge

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
### Before using and submitting an issue, please be sure to read the compatibility list and notes.

> Using in China Mainland \
> sudo -i && curl -sSO https://gitee.com/jimmykmi/QuickBash/raw/master/run.sh && bash run.sh && rm run.sh -f
>
> Using in the Other Places \
> sudo -i && curl -sSO https://raw.githubusercontent.com/JimmyKmi/QuickBash/master/run.sh && bash run.sh && rm run.sh -f

## Compatibility List

> If this column exists, it means it is theoretically compatible. An empty column means it has not been tested yet. If it is compatible, the tested system version will be written. X means it is not compatible.
> Note that "not compatible" refers to the script not being compatible, not necessarily the program itself.
> If you find that it is supported after testing, please create an issue for me, and I will continue to improve this table.

| /                         | Alibaba 3  | Anolis 8 | CentOS   | Ubuntu     |
|---------------------------|------------|----------|----------|------------|
| DEFAULT                   | 3.2104 LTS | --       | 8.5 UEFI | 20.04 UEFI |
| NVIDIA-GPUS[EXPERIMENTAL] | --         | --       | --       | 20.04 UEFI |

## Note

### Use in Production Environment
The author does not intend and will not be responsible for any issues in your production environment. Please follow the steps below to mitigate any potential risks.
1. The author uses this script in their own business, but it does not necessarily mean it will work flawlessly for you, as who knows if your system has any hidden issues?
2. It is recommended to fork the script and use your own branch to avoid accidentally installing the wrong things due to script updates.
3. Please read the script's execution content carefully before using it.
4. This script is designed for virtualized + unified network management scenarios (local firewall-equipped data centers, Alibaba Cloud, Tencent Cloud, Huawei Cloud, etc.). It will disable the system firewall by default and use a unified security group or egress/ingress firewall policy for easier management. If you need to use the system firewall, please delete the `firewall-off.sh` or modify its contents after forking.

### Compatibility and Adaptation
1. If your system is Synology, HomeAssistant, OpenWrt, iKuai, or some other unusual system, do not use this script in a production environment. However, you can refer to the instructions inside for input.
2. Compatibility with Synology may be added in the future if the author decides to or if someone provides a good solution.
3. This script's compatibility with some unusual devices such as Raspberry Pi is experimental. If you want to run it on any other unusual device, feel free to send it to me for research. (doge)