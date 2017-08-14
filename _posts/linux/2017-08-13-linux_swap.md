---
layout: post
title: Linux 创建swap分区
category: linux
tags: swap
comments: true
---

* content
{:toc}

# swap分区的作用

当系统的物理内存满了的情况下，这个时候如果系统需要更多的内存，那么系统会通过一定的算法將一部分“页面”放入到swap分区，swap分区是从磁盘上划分出来的一块空间。当你临时需要进行大量内存置换的操作时可以临时创建swap分区，以暂存内存中的数据。
# 检查swap分区

```
# 查看内存和swap分区的使用情况以 M 为单位
$ free -m

$ swapon -show

$ cat /proc/swaps
```

# 添加swap分区

可以在安装系统的时候创建swap分区，当然在系统安装好后如果想扩展swap分区有两种方式：
* 添加一个交换分区
* 添加一个交换文件

## 添加交换分区

```

```

## 添加交换文件

```
# 创建swap文件(5.12G) bs:扇区大小，count:扇区数量
# dd if=/dev/zero of=/swapfile bs=512k count=10240

# 设置交换文件（格式化）
# mkswap /swapfile

# 启动交换文件
# swapon /swapfile

# 停用交换文件
# swapoff /swapfile
```

## 开机自动加载swap分区/文件

```
# 写入/etc/fstab
/swapfile swap swap defautls 0 0
```
