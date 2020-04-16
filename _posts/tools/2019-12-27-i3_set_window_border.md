---
title: i3wm设置窗口的边框
category: tools
tags: i3wm
comments: true
---

##  设置窗口边框

```shell
for_window [class="urxvt"] border pixel 5
```

如何查找窗口的`class`属性

```shell
xprop | grep -i 'class'
```
然后点击想要查询的窗口,会看到相应的输出,如:

> WM_CLASS(STRING) = "urxvt", "URxvt"

## 参考链接

[for_window](https://i3wm.org/docs/userguide.html#for_window)
