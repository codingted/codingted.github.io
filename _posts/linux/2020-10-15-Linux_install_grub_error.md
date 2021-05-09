---
title: 解决Linux安装过程中不能安装Grub的问题
category: linux
tags: linux grub
comments: true
---

## 问题

在grub-install的时候，具体问题如下：

> zl-arch# grub-install /dev/sdb
> Installing for i386-pc platform.
> grub-install: warning: this GPT partition label contains no BIOS Boot Partition; embedding won't be possible.
> grub-install: error: embedding is not possible, but this is required for cross-disk install.


## 解决方法


在分区前面加上一个2MB大小的分区，设定它的标志为“bios_grub”。
如果你是Arch，那么可以在安装过程中下载：

```shell
zl-arch# pacman -S parted
```
然后执行：

```shell
# 这里的“1”就是那个2MB大小的分区位置
zl-arch# parted /dev/sdb set 1 bios_grub on
Information: You may need to update /etc/fstab.

<!-- more -->

zl-arch# parted /dev/sdb print
Model: ATA WDC WD20EZRX-00D (scsi)
Disk /dev/sdb: 2000GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt

Number  Start   End     Size    File system  Name  Flags
 1      17.4kB  3049kB  3032kB  ext4               bios_grub
sh-4.3# grub-install /dev/sdb
Installing for i386-pc platform.
Installation finished. No error reported.
```
这样就可以正常安装Grub了。

```shell
# 安装grub
zl-arch# grub-mkconfig -o /boot/grub/grub.cfg
```
