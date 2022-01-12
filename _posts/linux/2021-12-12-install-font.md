---
title: Linux 安装中文字体
category: linux
tags: linux font
---

1.查看系统中文字体

```bash
#fc-list :lang=zh
```

2.如果提示commont not fount 说明为安装fontconfig

3.安装fontconfig

```bash
#yum -y install fontconfig
```

4.再次查看系统中文字体

```bash
#fc-list :lang=zh
```

5.确认是否存在字体 -->> simhei.ttf

6.创建目录：

```bash
#mkdir -p /usr/share/fonts/my_fonts
```

7.将字体文件上传到该目录下

8.进入my\_fonts文件夹

9.生成字体索引

```bash
#mkfontscale
```

10.如果提示commont not font，则安装mkfontscale

```bash
#yum install mkfontscale
```
11.安装成功后，再次生成字体索引

```bash
#mkfontscale
```

12.执行命令

```bash
#mkfontdir
```

13.查看该文件夹的文件：

14.再次查看字体：

```bash
#fc-list :lang=zh
```
