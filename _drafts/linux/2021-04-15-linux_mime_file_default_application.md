---
title: 设置Linux文件默认桌面程序        
category: Linux     
tags:  linux mime   
---

## mimeapps.list

Path                    | Usage
------------------------|----------
~/.config/mimeapps.list |user overrides
/etc/xdg/mimeapps.list  |system-wide overrides
~/.local/share/applications/mimeapps.list   |(deprecated) user overrides
/usr/local/share/applications/mimeapps.list |distribution-provided defaults
/usr/share/applications/mimeapps.list       |distribution-provided defaults

## 查看现在桌面程序应用的desktop文件

> desktop 文件的位置：~/.local/share/applications  /usr/share/applications

## 查看文件类型

```shell
$ xdg-mime query filetype <文件路径>
```

## 设置文件类型

```shell
$ xdg-mime default <application.desktop> <filetype>
```


<!-- more -->

## 参考的文件

[XDG MIME Applications](https://wiki.archlinux.org/index.php/XDG_MIME_Applications)      
[Desktop entries](https://wiki.archlinux.org/index.php/Desktop_entries)
