---
layout: post
title: 回车和换行
category: linux
tags: computer
comments: true
---

* content
{:toc}

# 回车换行符的历史背景

早期的计算机输出设备不是显示器，而是电传打字机，结构与普通的打字机差不多。有一个打印头在纸上打字，同时有一个电动机控制纸张的进出。当打印头到达行尾的时候，需要两个动作才能够到达下一行的行首：首先执行回车动作，将打印头移动到本行的行首，然后进行换行动作，电动机将纸张向上移动一行，这样打印头就处于下一行的行首，可以继续进行打印。回车和换行对应的控制字符分别是\r和\n，这就是windows中换行符为\r\n的由来。后来由于经常连续执行，所以在打印机中将这两个控制字符简化为一个控制字符，这就是linux/unix中的换行符\n的由来。
Unix系统里，每行结尾只有“<换行>”，即“\n”；Windows系统里面，每行结尾是“ <回车><换行>”，即“\r\n”；Mac系统里，每行结尾是“<回车>”。一个直接后果是，Unix/Mac系统下的文件在Windows里打开的话，所有文字会变成一行；而Windows里的文件在Unix/Mac下打开的话，在每行的结尾可能会多出一个^M符号.

# 区别

* 回车符：\r=0x0d (13) return； #回车（carriage return）   
* 换行符：\n=0x0a (10) newline。#换行（newline）

> 文本文件的行结束符:
> * 传统上 PC机 用 CRLF;
> * 苹果机用CR;
> * unix 用 LF。
>
>  **编程**   
> 【CR -- 回车符，c语言'\r'】。【LF -- 换行符， c语言'\n'】。
>  ctrl+M: ^M 也称回车键

## liunx下文件格式互转命令

> linux 安装命令 sudo apt-get install tofrodos

* unix2dos：将具有unix风格的格式文件转化为具有window下的格式文件。
* dos2unix：将具有windows风格的格式文件转化为unix下的格式文件。
