---
title: chrome默认使用google.com
categories: tools
tags: chrome
---

# 问题

在使用Chrome的时候，Google为增强本地化搜索，或将默认的Google搜索引擎转换为本地语言，如在中国会自动转到google.com.hk，日本会会自动转到google.co.jp，如何忽略本地话的优化,使用www.google.com?

# 方法

找到如下文件： 
Windows 路径：`%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences`  
Linux 路径：`~/.config/google-chrome/Default/Preferences`   
Mac 路径：`/Users/yourname/Library/Application Support/Google/Chrome/Default/Preferences`   
文本编辑器打开后替换全文终的 google.co.jp 为 google.com 即可。 
