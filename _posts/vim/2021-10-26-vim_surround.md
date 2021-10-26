---
title: vim-surround 
category: tools
tags: vim
comments: true
---
## 介绍

> vim-surround,tpope大神的一款life-changed插件，和文本对象组合使用能让更改成对的符号异常方便,安装完成以后直接就可以使用

## 使用
```vim
 Old text                  Command     New text ~
 "Hello *world!"           ds"         Hello world!
 [123+4*56]/2              cs])        (123+456)/2
 "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
 if *x>3 {                 ysW(        if ( x>3 ) {
 my $str = *whee!;         vlllls'     my $str = 'whee!';
 <div>Yo!*</div>           dst         Yo!
 <div>Yo!*</div>           cst<p>      <p>Yo!</p>

# *代表当前光标位置，添加替换时使用后半括号)]}，添加的括号和内容间就没有空格（如第2个示例），反之会在内容前后添加一个空格（如第4个实例）
```

## 命令列表

```vim
Normal mode
-----------
ds  - delete a surrounding
cs  - change a surrounding
ys  - add a surrounding
yS  - add a surrounding and place the surrounded text on a new line + indent it
yss - add a surrounding to the whole line
ySs - add a surrounding to the whole line, place it on a new line + indent it
ySS - same as ySs

Visual mode
-----------
s   - in visual mode, add a surrounding
S   - in visual mode, add a surrounding but place text on new line + indent it

Insert mode
-----------
<CTRL-s> - in insert mode, add a surrounding
<CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent
<CTRL-g>s - same as <CTRL-s>
<CTRL-g>S - same as <CTRL-s><CTRL-s>
```

## Vim基于surrounding的文本编辑
提到了surround插件，不得不提一下Vim中广为人知的对surrounding内文本的编辑功能，其实surround插件就是对Vim这部分功能的增强。原理和细节请参照vim中的[text-object motion](http://vimdoc.sourceforge.net/htmldoc/motion.html)，这里只列举一些常见用法。可以不夸张的说，任何习惯了vim中[operation+motion](https://blog.carbonfive.com/vim-text-objects-the-definitive-guide/)操作的人都会上瘾的，其他编辑器都是个渣了。

以修改surrounding内文本为例：
```vim
ci[ ci( ci< ci{ 删除一对 [], (), <>, 或{} 中的所有字符并进入插入模式
ci” ci’ ci` 删除一对引号字符 ”  ‘ 或 ` 中所有字符并进入插入模式
cit 删除一对 HTML/XML 的标签内部的所有字符并进入插入模式
```
其他常见operation

```vim
ci: 例如，ci(，或者ci)，将会修改()之间的文本；
di: 剪切配对符号之间文本；
yi: 复制；
ca: 同ci，但修改内容包括配对符号本身；
da: 同di，但剪切内容包括配对符号本身；
ya: 同yi，但复制内容包括配对符号本身。
PS. dib等同于di(。diB等同于di{。
```
## 转自
[http://zuyunfei.com/2013/04/17/killer-plugin-of-vim-surround/](http://zuyunfei.com/2013/04/17/killer-plugin-of-vim-surround/)
