---
title: dd命令生成固定大小的文件
category: linux
tags: linux dd
comments: true
---

## 选项

> bs=<字节数>：将 ibs（输入）与 obs（输出）设成指定的字节数；
> cbs=<字节数>：转换时，每次只转换指定的字节数；
> conv=<关键字>：指定文件转换的方式；
> count=<区块数>：仅读取指定的区块数；
> ibs=<字节数>：每次读取的字节数；
> obs=<字节数>：每次输出的字节数；
> of=<文件>：输出到文件；
> seek=<区块数>：一开始输出时，跳过指定的区块数；
> skip=<区块数>：一开始读取时，跳过指定的区块数；
> --help：帮助；
> --version：显示版本信息。

## 常用

```shell
# 生成固定大小的文件
$ dd if=/dev/zero of=sun.txt bs=1M count=1

# 备份硬盘（慎重）
$ dd if=/dev/hda of=/dev/hdb

# 测试磁盘的读写速度
$ dd if=/dev/zero bs=1024 count=1000000 of=/root/1Gb.file
$ dd if=/root/1Gb.file bs=64k | dd of=/dev/null
```

## 常用的计量单位

单元大小        |单位
----------------|------------
字节（1B）	    |c
字节（2B）	    |w
块（512B）	    |b
千字节（1024B）	|k
兆字节（1024KB）|M
吉字节（1024MB）|G

