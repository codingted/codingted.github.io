---
title: Arch Linux pacman 软件包管理
category: linux
tags: linux arch pacman
---

## 软件包基础搜索及安装卸载
```bash
$ pacman -Ss 软件名称 //(搜索软件包)
$ pacman -S 软件名称 //(安装软件包)
$ pacman -Rs 软件名称 //(卸载软件包)
$ pacman -Syu (更新)
```

## 包的查询及清理
```bash
#列出所有本地软件包（-Q,query查询本地；-q省略版本号）
$ pacman -Qq (列出有904个包)	

#列出所有显式安装（-e,explicitly显式安装；-n忽略外部包AUR）
$ pacman -Qqe (列出222个包)

#列出自动安装的包（-d,depends作为依赖项）
$ pacman -Qqd (列出682个)

#列出孤立的包（-t不再被依赖的"作为依赖项安装的包"）
$ pacman -Qqdt (列出0个)
#注意：通常这些是可以妥妥的删除的。
$ sudo pacman -Qqdt | sudo pacman -Rs -
```

## 软件包和文件的查询
```bash
#列出包所拥有的文件
$ sudo pacman -Ql i3-gaps
iw /usr/
iw /usr/bin/
iw /usr/bin/iw
iw /usr/share/
iw /usr/share/man/
iw /usr/share/man/man8/
iw /usr/share/man/man8/iw.8.gz

#check 检查包文件是否存在（-kk用于文件属性）
$ sudo pacman -Qk iw
iw: 7 total files, 0 missing files

#查询提供文件的包
$ sudo pacman -Qo /usr/share/man/man8/iw.8.gz
/usr/share/man/man8/iw.8.gz is owned by iw 5.0.1-1
```

## 查询包详细信息
```bash
#查询包详细信息（-Qi;-Qii[Backup Files]）(-Si[Repository,Download Size];-Sii[Signatures,])
$ pacman -Qi 包名
Repository 仓库名称（要联网用pacman -Si或Sii才能看到这一栏；）
Name 名称
Version 版本
Description 描述
Architecture 架构
URL 网址
Licenses 许可证
Groups 组
Provides 提供
Depends On 依赖于（依赖那些包）
Optional Deps 可选项
Required By 被需求的（被那些包需求）
Optional For 可选项
Conflicts With 与...发生冲突
Replaces 替代对象
Download Size 下载大小（要联网用pacman -Si或Sii才能看到这一栏；）
Installed Size 安装尺寸
Packager 包装者
Build Date 包装日期
Install Date 安装日期
Install Reason 安装原因（主动安装，还是被依赖自动安装）
Install Script 安装脚本
Validated By 验证者
```

## 卸载不再被需要的软件包
```bash
#删除不再被需要的(曾经被依赖自动安装的程序包)
$ sudo pacman -Qqdt | sudo pacman -Rs -    
$ sudo pacman -Q |wc -l
905
$ sudo pacman -Qe |wc -l
223
$ sudo pacman -Qd |wc -l
682
$ sudo pacman -Qdt |wc -l
0
```

## 清除多余的安装包缓存(pkg包)
使用pacman安装的软件包会缓存在这个目录下 /var/cache/pacman/pkg/ ，可以清理如下2种。
-k (-k[n])保留软件包的n个最近的版本，删除比较旧的软件包。
-u (-u)已卸载软件的安装包(pkg包)。

```bash
#删除，默认保留最近的3个版本，-rk3
$ paccache -r 
==> finished: 6 packages removed (disk space saved: 194.11 MiB)
#删除，默认保留最近的2个版本
$ paccache -rk2
#删除，默认保留最近的1个版本
$ paccache -rk1 
```


## 通过日志查看安装历史
```bash
#查看软件管理所操作日志。
$ cat /var/log/pacman.log |wc -l
4650
$ cat /var/log/pacman.log |grep installed |wc -l
1045
$ cat /var/log/pacman.log |grep running |wc -l
693
$ cat /var/log/pacman.log |grep Running |wc -l
693
$ cat /var/log/pacman.log |grep removed |wc -l
87
$ cat /var/log/pacman.log |grep upgraded |wc -l
821

通过系统日志查看安装记录(速度可能较慢)
$ sudo journalctl |grep irssi
Jul 11 21:04:46 tompc sudo[11619]: toma : TTY=pts/2 ; PWD=/home/toma ; USER=root ; COMMAND=/usr/bin/pacman -Ss irssi
Jul 11 21:06:11 tompc sudo[11841]: toma : TTY=pts/2 ; PWD=/home/toma ; USER=root ; COMMAND=/usr/bin/pacman -S irssi
Jul 11 21:06:11 tompc pacman[11842]: Running 'pacman -S irssi'
Jul 11 21:06:27 tompc pacman[11842]: installed irssi (1.2.1-1)

$ sudo journalctl |grep pidgin
Jul 11 21:04:55 tompc sudo[11662]: toma : TTY=pts/2 ; PWD=/home/toma ; USER=root ; COMMAND=/usr/bin/pacman -Ss pidgin
Jul 11 21:06:57 tompc sudo[12000]: toma : TTY=pts/2 ; PWD=/home/toma ; USER=root ; COMMAND=/usr/bin/pacman -S pidgin
Jul 11 21:06:57 tompc pacman[12001]: Running 'pacman -S pidgin'

系统日志筛选更新记录
$ sudo journalctl |grep 'upgraded chromium'
Jun 15 06:39:47 tompc pacman[5551]: upgraded chromium (75.0.3770.80-1 -> 75.0.3770.90-2)
Jun 19 10:20:45 tompc pacman[1904]: upgraded chromium (75.0.3770.90-2 -> 75.0.3770.90-3)
Jun 23 17:18:33 tompc pacman[7079]: upgraded chromium (75.0.3770.90-3 -> 75.0.3770.100-1)
```

## 链接
[参考链接](https://www.cnblogs.com/sztom/p/10652624.html)