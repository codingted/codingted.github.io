---
layout: blog
categories: linux
title: 那些鲜为人知的Vim小技巧
tags: Vim Bash 
---

# 用拷贝的内容替换

当发生拼写错误或者想要重命名标识符时，就需要用拷贝的内容来替换当前的名字。比如调用函数时写错了：

```cpp
void letus_fuckit_with_vim(){
    cout<<"great!";
}
let_fuckat_with_vom();
```

只需要先复制上面的函数名，再把光标切换到拼错的词首。然后按下`viwp`，就替换过来了：

```cpp
void letus_fuckit_with_vim(){
    cout<<"great!";
}
letus_fuckit_with_vim();
```

> `v`进入可视模式，输入`i`表示选好之后要插入，然后`w`来选择一个单词（你可以选择任何区域），最后按下`p`来粘贴。

# 字符查找

[Vim光标跳转][vim-cursor]虽然有数十种快捷键，但你有没有发现当我们碰到长单词时会很无力，比如我想把下面的`description`替换为`keywords`：

```
tmystr_meta_description
```

是不是要不断地敲`l`（或者敲几次`{num}l`），其实可以用单词查找功能。只需要输入`fd`便可以查找当前行的下一个字母`d`。大写的`F`可以反向查找。

# 段落跳转

这个对中文用户几乎无用，但我们在编辑代码文件时会很有用。`()`可以调到句首句尾，`{}`可以调到段首段尾。

# 选区头尾跳转

Emmet插件可以进行HTML的标签匹配，你按下`<c-y>d`当前标签首尾之间被选中。你想调到选中区域的尾部怎么办？
按下`o`即可切换收尾，再次按下`v`就能回到Normal模式。

# 自动补全

omnifunc

`<c-x><c-o>`

[vim-cursor]: {% post_url 2015-11-07-vim-cursor %}