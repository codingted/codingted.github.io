---
layout: post
title:  "ubuntu扩容(重新划分/home分区)"
categories: linux
tags: linux 分区
comments: true
---

* content
{:toc}


# 背景

windows+ubuntu双系统(平时是在ubuntu下使用的,windows作为备份),因为前期装系统没有合理规划分区,导致现在Ubuntu系统的可用容量仅剩下85%(总共59G,剩余6G),而且ubuntu只有一个/分区和swap分区.

![系统分区现状]({{ site.img_server }}/linux/img/sys_origin.jpg)

# 解决方案

* 重装系统

    简单粗暴,如果现在系统已经有太多的数据或应用软件及配置,这种做法成本是很高的(不推荐)
* 挂载硬盘添加容量

    如果需要的容量比较大,这种方法能比较直接的解决问题
* 重新分区,扩展容量
    小幅度的调整系统中的存储空间的分配(本文就选择的这种方法)








# 扩展分区

## 目标分区

![分区目标]({{ site.img_server }}/linux/img/sys_target.jpg)

* 將原windows的D:分区变为ubuntu的/home分区;
* 將原windows的C:盘分出250G的空间作为ubuntu的/home分区的备份分区

## windows操作

* 將D盘数据内容备份,并將安装软件迁移或重新安装
* 通过windows的`管理`-->`磁盘管理`-->`压缩`进行重新分区

    如果可用容量远小于可压缩容量可能需要进行`碎片整理`再进行`压缩`

完成之后重启进入ubuntu系统

## ubuntu操作

* 安装GParted软件

```
#apt install gparted
```

* 重新格式化

![格式化分区]({{ site.img_server }}/linux/img/resize.jpg)

* 拷贝home目录到新的分区

```
#挂载分区
mount /dev/sdb1 /mnt/home_new

#拷贝目录到新的分区
sudo cp -Rp /home/* /mnt/home_new
```

* 修改/etc/fstab

```
# 查看新挂载的分区的UUID
sudo blkid
```
![查看block的UUID]({{ site.img_server }}/linux/img/blkid.jpg)

```
#备份原fstab
sudo cp /etc/fstab /etc/fstab.backup

#修改fstab
vi /etc/fstab

# 添加以下内容
UUID=(your block UUID)     /home     ext4     nodev,nosuid     0     2
```

* 移除home目录

```
#挂载备份分区
mount /dev/sda4 /mnt/home_backup
#备份
cd / && sudo mv /home /home_backup && sudo mkdir /home
```

* 重新启动

```
sudo reboot
```

# 总结

* 提前规划自己的分区
* 了解自己的分区状况
* 合理规划(慎重重装你的系统)

参考链接:[https://www.howtogeek.com/116742/how-to-create-a-separate-home-partition-after-installing-ubuntu/](https://www.howtogeek.com/116742/how-to-create-a-separate-home-partition-after-installing-ubuntu/)
