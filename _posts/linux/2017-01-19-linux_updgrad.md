---
layout: post
title: Ubuntu16.04升级到17.10
category: linux
tags: ubuntu
comments: true
---

* content
{:toc}

## 命令行升级

> **重要：** 备份你的数据

```shell
sudo apt update && sudo apt autoremove && sudo apt dist-upgrade
sudo apt install update-manager-core
sudo do-release-upgrade -d
```





## 安装过程

刚开始想是能一步升级到17.10但是在升级的过程中只能下载到ubuntu17.04的版本，后来各种换源（刚开始使用的是阿里的源）各种尝试都不行，最后只好两部升级的（先升级到17.04在升级到17.10）。
升级的过程中很顺利，现在每次升级大概需要一个小时的样子。

升级的变化：
* 登陆可以选择登陆的图形界面

记录一下更新后的问题，方便后续解决：
* 搜狗输入法不好使了
*

