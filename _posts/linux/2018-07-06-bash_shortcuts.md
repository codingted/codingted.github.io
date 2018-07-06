---
title: bash快捷键
categories: linux
tags: bash tools
comments: true
---

## 介绍

生活在Linux的世界中"效率党"必须要掌握一些高效的快捷键操作,下边来了解一下bash下的快捷键

## 快捷键

快捷键      | 说明
------------|---------------
`C-c`       | 终止一个前台的进程(INT signal)
`C-z`       | 挂起一个前台的进程(当然也可以在执行命令之前使用当然也可以在执行命令之后使用'&')( TSTP signal)
`C-^`       | 终止一个前台的进程(QUIT signal)
`C-d`       | 关闭输入流(EOF, End-Of-File)
`C-l`       | 清空屏幕
`C-a`       | 定位到命令行的开头
`C-e`       | 定位到命令行的结尾
`C-f`       | 按字符前移
`C-b`       | 按字符后移
`A-f`       | 按单词前移
`A-b`       | 按单词后移
`C-u`       | 删除整行
`C-k`       | 删除至命令行尾
`C-w`       | 向命令行尾删除每次删除一个单词
`A-d`       | 光标处删除至字尾
`C-d`       | 删除光标处的字符
`C-h`       | 删除光标前的字符
`C-y`       | 粘贴至光标
`A-c`       | 修改光标出的字母为大写并跳到下一个单词首字母
`A-u`       | 从光标处修改为全部大写
`A-i`       | 从光标出更改为全部小写
`C-t`       | 交换光标处和之前的字符
`A-t`       | 交换光标处和之前的单词
`A-Backspace`| 交换光标处和之前的单词
`C-t`       | 交换光标处和之前的字符

## Bang (!) 命令

快捷键      | 说明
------------|---------------
!!          | 执行上一条命令
!blah       | 执行最近的以 blah 开头的命令，如 !ls
!blah:p     | 仅打印输出，而不执行
!$          | 上一条命令的最后一个参数，与 Alt + . 相同
!$:p        | 打印输出 !$ 的内容
!*          | 上一条命令的所有参数
!*:p        | 打印输出 !* 的内容
^blah       | 删除上一条命令中的 blah
^blah^foo   | 将上一条命令中的 blah 替换为 foo
^blah^foo^  | 将上一条命令中所有的 blah 都替换为 foo

## 参考链接

[https://linuxtoy.org/archives/bash-shortcuts.html](https://linuxtoy.org/archives/bash-shortcuts.html)

[https://linuxhandbook.com/linux-shortcuts/](https://linuxhandbook.com/linux-shortcuts/)
