---
layout: post
title: linux find command
categories: linux
tags: linux find
comments: true
---

* content
{:toc}

# Linux 中的查找命令

## find 命令

由于find具有强大的功能，所以它的选项也很多，其中大部分选项都值得我们花时间来了解一下。即使系统中含有网络文件系统( NFS)，find命令在该文件系统中同样有效，只你具有相应的权限。
在运行一个非常消耗资源的find命令时，很多人都倾向于把它放在后台执行，因为遍历一个大的文件系统可能会花费很长的时间(这里是指30G字节以上的文件系统)。

find命令的一般形式为:
```
find pathname -options [-print -exec -ok ...] 	
如 : find / -name "filename"

目的：在根目录“/”开始搜被称为filename的文件，“filename”文件名可以包含通配符（*，？），注意：filename是文件名字符串，可以带双引号，也可不带find命令功能强大，它有很多选项让你以不同的方式搜索文件，例如，通过日期，文件大小，权限，拥有者等等。
find命令的参数；
pathname: find命令所查找的目录路径。例如用.来表示当前目录，用/来表示系统根目录。
-print： find命令将匹配的文件输出到标准输出。
-exec： find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为'command' { } ;，注意{ }和；之间的空格。
-ok： 和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。
```
find命令选项
```
-name
按照文件名查找文件。
-perm
按照文件权限来查找文件。
-prune
使用这一选项可以使find命令不在当前指定的目录中查找，如果同时使用-depth选项，那么-prune将被find命令忽略。
-user
按照文件属主来查找文件。
-group
按照文件所属的组来查找文件。
-mtime -n +n
按照文件的更改时间来查找文件， - n表示文件更改时间距现在n天以内，+ n表示文件更改时间距现在n天以前。find命令还有-atime和-ctime 选项，但它们都和-m time选项。
-nogroup
查找无有效所属组的文件，即该文件所属的组在/etc/groups中不存在。
-nouser
查找无有效属主的文件，即该文件的属主在/etc/passwd中不存在。
-newer file1 ! file2
查找更改时间比文件file1新但比文件file2旧的文件。
-type
查找某一类型的文件，诸如：
b - 块设备文件。
d - 目录。
c - 字符设备文件。
p - 管道文件。
l - 符号链接文件。
f - 普通文件。
-size n：[c] 查找文件长度为n块的文件，带有c时表示文件长度以字节计。
-depth：在查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。
-fstype：查找位于某一类型文件系统中的文件，这些文件系统类型通常可以在配置文件/etc/fstab中找到，该配置文件中包含了本系统中有关文件系统的信息。
-mount：在查找文件时不跨越文件系统mount点。
-follow：如果find命令遇到符号链接文件，就跟踪至链接所指向的文件。
-cpio：对匹配的文件使用cpio命令，将这些文件备份到磁带设备中。
```

## locate 命令

locate filename 	
locate命令其实是“find -name”的另一种写法，但是要比后者快得多，原因在于**它不搜索具体目录，而是搜索一个数据库（/var/lib/locatedb）**，这个数据库中含有本地所有文件信息。Linux系统自动创建这个数据库，并且每天自动更新一次，所以使用locate命令查不到最新变动过的文件。为了避免这种情况，可以在使用locate之前，先使用updatedb命令，手动更新数据库。

locate命令的使用实例：

```
　　$ locate /etc/sh
搜索etc目录下所有以sh开头的文件。
　　$ locate ~/m
搜索用户主目录下，所有以m开头的文件。
　　$ locate -i ~/m
搜索用户主目录下，所有以m开头的文件，并且忽略大小写。

发现包含字符串“filename”的文件名。这比find命令更容易。但是基于数据库（通常在夜间重建），所以你无法找到刚刚存到文件系统的文件。为了强制立即更新数据库，作为超级用户可以使用：updatedb& （中间没有空格）
```

## which命令

which executeable_name 	
查找可执行文件，根据可执行文件的文件名。	 
例如 which apache2 ， 返回/usr/sbin/apache2

**以文件内容查找**

1. grep -n 字符串名字 /filepath/filename
返回包含该字符串的该行，可以是多行。且包含行数。
2. sudo gedit /filepath/filename
而后，用ctrl+F 去查找相应的字符串。
3. vi或者less命令可以查找相应的内容
例如 vi /filepath/filename而后，输入 “/字符串” ，按下字母“n”到下一个匹配的字符串
4. tail命令

**查看文件内容的特殊方法**

1. 如果你只想看文件的前5行，可以使用head命令，如：
head -5 /etc/passwd
2. 如果你想查看文件的后10行，可以使用tail命令，如：
tail -20 /etc/passwd
tail -f /var/log/messages
参数-f使tail不停地去读最新的内容，这样有实时监视的效果
tail -f /var/log/messages
按Ctrl+C后，直接从脚本退出到提示符下了
