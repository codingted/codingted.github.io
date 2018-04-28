---
title: 修改网卡为eth0
category: linux
tags: network linux
---

* sudo vi /etc/default/grub

> 找到GRUB_CMDLINE_LINUX=""     
> 改为GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"  
> 然后sudo grub-mkconfig -o /boot/grub/grub.cfg     
> 重启后，网卡名称就变成了eth0和wlan0     

* 打开ubuntu的/etc/network/interfaces文件默认的内容如下：

```bash
# 开启本地
auto lo
iface lo inet loopback

# 自动获取ip
#auto eth0
#iface eth0 inet dhcp
# 静态ip地址
iface eth0 inet static
address 10.1.22.34
gateway 10.1.22.254
address 192.168.1.21
gateway 192.168.1.1
netmask 255.255.255.0
# dns
dns-nameservers 219.141.136.10 219.141.140.10
dns-nameservers 114.114.114.114
dns-nameservers 8.8.8.8 
```

重启

转自:[ubuntu16.04修改网卡名称enp2s0为eth0](https://blog.csdn.net/wenwenxiong/article/details/52937539)
