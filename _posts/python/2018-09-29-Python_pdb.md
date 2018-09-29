---
title: Python调试
category: python
tags: python pdb
---

# pdb介绍
pdb 是 python 自带的一个包，为 python 程序提供了一种交互的源代码调试功能，主要特性包括设置断点、单步调试、进入函数调试、查看当前代码、查看栈片段、动态改变变量的值等。pdb 提供了一些常用的调试命令

**<U>pdb常用命令</U>**

命令        | 解释
------------|--------------
break 或 b  | 设置断点
continue 或 c | 继续执行程序
list 或 l   | 查看当前行的代码段
step 或 s   | 进入函数
return 或 r | 执行代码直到从当前函数返回
exit 或 q   | 中止并退出
next 或 n   | 执行下一行
pp          | 打印变量的值
help        | 帮助

<!-- more -->

# 示例

```python
import pdb 
a = "aaa"
pdb.set_trace() 
b = "bbb"
c = "ccc"
final = a + b + c 
print final
```

运行脚本会停留在`pdb.set_trace()`处,输入命令按下Enter可以执行该命令,重复执行上次的命令只需按下Enter键即可.
如果在调试过程中需要为变量赋值可以使用`!`(如:`!b = "change"`)

# 参考

* [https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/index.html](https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/index.html)  
