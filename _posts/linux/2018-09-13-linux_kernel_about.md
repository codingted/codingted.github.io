---
title: Linux内核操作
category: linux
tags: kernel linux
---

## 查看内核信息

```sh
# 显示所有信息
$ uname -a 
```
> `Linux ubu1804 4.15.1-041501-generic #201802031831 SMP Sat Feb 3 18:32:13 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux`

```sh
# 显示内核信息
$ uname -rs
```
> `Linux 4.15.1-041501-generic`

<!-- more -->

## 更新内核

*下载内核*

```sh
# 32-Bit System
$ wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17/linux-headers-4.17.0-041700_4.17.0-041700.201806041953_all.deb
$ wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17/linux-headers-4.17.0-041700-generic_4.17.0-041700.201806041953_i386.deb
$ wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17/linux-image-4.17.0-041700-generic_4.17.0-041700.201806041953_i386.deb

# 64-Bit System
$ wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17/linux-headers-4.17.0-041700_4.17.0-041700.201806041953_all.deb
$ wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17/linux-headers-4.17.0-041700-generic_4.17.0-041700.201806041953_amd64.deb
$ wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17/linux-image-unsigned-4.17.0-041700-generic_4.17.0-041700.201806041953_amd64.deb
```

**下载完成后安装**

```sh
$ sudo dpkg -i *.deb
```
重启后生效

## 卸载内核

```sh
$ sudo apt autoremove
```
> 这个命令删除系统不再依赖的软件包,包括旧版本的内核文件`linux-headers-*`和`linux-image-*`(删除的同时会自动保留最近的内核作为备份)

**删除指定的内核**

* 使用synaptic软件进行卸载`sudo apt install synaptic`
* 命令行删除指定的内核

```sh
$ sudo apt remove --purge linux-image-4.4.0-21-generic
$ sudo update-grub2
$ sudo reboot
```

# 参考

* [https://www.tecmint.com/upgrade-kernel-in-ubuntu/](https://www.tecmint.com/upgrade-kernel-in-ubuntu/)  
* [https://askubuntu.com/questions/2793/how-do-i-remove-old-kernel-versions-to-clean-up-the-boot-menu](https://askubuntu.com/questions/2793/how-do-i-remove-old-kernel-versions-to-clean-up-the-boot-menu)  
* [https://mirrors.edge.kernel.org/pub/linux/kernel/](https://mirrors.edge.kernel.org/pub/linux/kernel/)
