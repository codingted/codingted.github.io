---
title: Vim快捷键配置
tags: Linux Vim
---

## 快捷键的修改

### 递归绑定和非递归绑定

```shell
" 非递归方式
noremap <space> :
noremap : /

" 递归方式
map <space> :
map : /
```

第一种方式输入空格会变为命令模式`：`，输入`：`会变为搜索按键`/`。   
第二种方式输入空格会变为搜索按键`/`

### 绑定模式

vim包含六类`mapping`模式，vim官方帮助文档：

> There are six sets of mappings
>
> * For Normal mode: When typing commands.(`nnoremap`)
> * For Visual mode: When typing commands while the Visual area is highlighted.
> * For Select mode: like Visual mode but typing text replaces the selection.
> * For Operator-pending mode: When an operator is pending (after "d", "y", "c", etc.). See below: |omap-info|.
> * For Insert mode. These are also used in Replace mode.(`inoremap`)
> * For Command-line mode: When entering a ":" or "/" command.(`cnoremap`)

几种按键绑定模式的用法：

```shell
inoremap jk <Esc>
nnoremap <space> :
cnoremap <C-a> <Home>
```
这些绑定前边的`i`(Insert),`n`(Normal),`c`(Command-line)代表不同的模式,如果没有指明使用那一种模式，如直接使用：

```shell
noremap <Space> :
```
表示同时绑定到`normal`,`visual`,`operator-pending`三种模式

### mapleader

因为vim很多键都有特殊含义，所以增加`mapleader`来增加快捷键的层次。

```shell
" 设置mapleader 为;
let mapleader=";"

" 拷贝到剪切板快捷键
map <Leader>j "+y
```

## 参考

[利器系列之 —— 编辑利器 Vim 之快捷键配置](http://blog.guorongfei.com/2015/09/03/vim-shortcut/)
