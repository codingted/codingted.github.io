---
title: Arch Linux 设置默认打开程序
category: linux
tags: linux arch mime
---

## 所有桌面程序的.desktop文件位置

> /usr/share/applications

[arch wiki](!https://wiki.archlinux.org/title/XDG_MIME_Applications)

## 设置默认打开程序

```bash
# 查询文件类型
$ xdg-mime query filetype some.xlsx

# 查询当前打开该种类型的文件所使用的应用程序
$ xdg-mime query default application/octet-stream

# 设置默认应用程序
$ xdg-mime default .wps-office-et.desktop application/octet-stream
```
