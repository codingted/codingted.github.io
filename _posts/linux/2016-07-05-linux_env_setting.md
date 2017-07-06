---
layout: post
title: env环境变量
category: linux
tags: env
comments: true
---

* content
{:toc}

# 环境变量

Linux中环境变量包括系统级和用户级，系统级的环境变量是每个登录到系统的用户都要读取的系统变量，而用户级的环境变量则是该用户使用系统时加载的环境变量。

## 系统级

1. /etc/profile：该文件是用户登录时，操作系统定制用户环境时使用的第一个文件，应用于登录到系统的每一个用户。该文件一般是调用/etc/bash.bashrc文件。
**/etc/bash.bashrc：系统级的bashrc文件。**
2. /etc/environment:在登录时操作系统使用的第二个文件,系统在读取你自己的profile前,设置环境文件的环境变量。

## 用户级

1. ~/.profile:每个用户都可使用该文件输入专用于自己使用的shell信息,当用户登录时,该文件仅仅执行一次!默认情况下,他设置一些环境变量,执行用户的.bashrc文件。这里是推荐放置个人设置的地方
2. ~/.bashrc:该文件包含专用于你的bash shell的bash信息,当登录时以及每次打开新的shell时,该该文件被读取。不推荐放到这儿，因为每开一个shell，这个文件会读取一次，效率有影响。