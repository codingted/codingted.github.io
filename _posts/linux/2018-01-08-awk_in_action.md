---
title: awk实用程序
category: linux
tags: linux awk
comments: true
---


## 介绍

`AWK`是一种为文本处理设计的编程语言,通常用作数据处理.是`Unix-like`系统中的标准功能.[wiki](https://en.wikipedia.org/wiki/AWK)

## 基本操作

```shell
# 输出包含word字符串的行
$ awk '/word/' file

# 对第一个字段里匹配到Ted或者ted的行进行显示
$ awk '$1 ~ /[Tt]ed/' file

# 显示不是以ly结尾的行
$ awk '$1 !~ /ly$/' file

# 显示最后一个字段
$ awk '{print $NF}' file

# 查找计数
$ awk '/Ted/{count++}END{print "Ted found " count " times."}' file
```

<!-- more -->

## 比较运算

awk所有的运算都是浮点运算

### 比较运算符

运算符  | 含义  |例子
--------|-------|-----
<       | 小于  |
<=      | 小于等于|
==      | 等于  |
!=      | 不等于|
>       | 大于  |
>=      | 大于等于|
~       | 正则匹配| ~/word/
!~      | 正则不匹配| !~/word/

### 逻辑运算符

运算符  | 含义  |例子
--------|-------|-----
&&      | 与    | a && b
||      | 或    | a || b
!       | 非    | !a

### 变量

```
# 赋值
name = "Ted"

# 初始化0然后+1
number++

# 字符串强转为数字
name + 0

# 数字转换为字符串
number ""

```

#### BEGIN模式

BEGIN模式后跟的操作块，awk会在处理输入文件之前先执行该操作块中的内容。

#### END模式

END模式不匹配任何输入行，而是执行任何与之关联的的操作。awk处理玩所有的输入行才处理END模式
## POSIX字符类

括号类      | 含义
------------|-----------
[:alnum:]   | 字母数字
[:alpha:]   | 字母
[:cntrl:]   | 控制字符
[:digit:]   | 数字字符
[:graph:]   | 非空白字符（非空格，控制字符）
[:lower:]   | 小写字母
[:print:]   | 与graph类似只是包含空格
[:punct:]   | 标点
[:space:]   | 所有空白字符（换行/空格/制表符）
[:upper:]   | 大写字母
[:xdigit:]  | 允许十六进制的数字


