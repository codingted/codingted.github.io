---
title: Linux设置静态ip
category: linux
tags: 网络
comments: true
---

## 命令设置ip地址

1. 设置IP sudo ifconfig eth0 203.171.239.155 netmask 255.255.255.224 这样就算设置好了网卡eth0的IP地址和子网掩码
2. 设置网关 sudo route add default gw 203.171.239.129
3. 设置DNS 修改/etc/resolv.conf，在其中加入 nameserver DNS的地址1 nameserver DNS的地址2 完成。不过，这样设置之后，下次开机时候IP不存在了，需要重新设置。

<!-- more -->

## 直接修改系统配置文件

Ubuntu的网络配置文件是：/etc/network/interfaces
修改完生效的命令：sudo /etc/init.d/networking restart

### DHCP 方式配置网卡

编辑 /etc/network/interfaces 以下边的两行替换eth0（**默认网卡也不全是eth0需要视具体情况而定**）相关的行

```text
# The primary network interface - use DHCP to find our address  
auto eth0  
iface eth0 inet dhcp
```
使用命令 sudo /etc/init.d/networking restart 生效

> 也可以直接使用：sudo dhclient eth0

### 为网卡配置静态IP地址

编辑 /etc/network/interfaces    
配置如下：
```text
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
address 10.1.23.34
gateway 10.1.23.254
netmask 255.255.255.0
# 可以在这里设置dns
#dns-nameservers 114.114.114.114
```
### 配置默认dns

编辑/etc/resolvconf/resolv.conf.d/base    
内容为：
```
nameserver 114.114.114.114
```

别忘记生效(**sudo /etc/init.d/networking restart**)
