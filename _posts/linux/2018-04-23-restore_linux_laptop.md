---
title: Ubuntu安装后的软见配置
category: linux
tags: linux Ubuntu
---

# 简介

因为升级了Ubuntu的新版本导致图形界面启动不了,试过了重新安装显卡驱动,修改启动的参数...,最终还是要重新安装系统,前提是你需要备份自己的`/home`目录, 以及其它的修改的配置文件,但是以往安装的软件需要进行重新安装,本文记录了我在重装后安装的一些工具和重置的一些配置,**为了下一次的重装系统**(生命不息,折腾不止!!!)

# 恢复环境

## 更新软件源

```bash
$ sudo apt update
```
## 网络相关

### 安装Chrome

```bash
# chromium-bowser 是chrome的开源版本，可以在软件源中直接下载
$ sudo apt install chromium-bowser
```
安装代理插件[proxy SwichyOmega](https://pan.baidu.com/s/1P6EyhF96TasEpOjoBEgQsw)
启动代理开启google模式（[代理服务器介绍](http://www.codingted.com/2017/08/26/proxy.html)）

### 安装shadowsocks(附:安装pip)

安装pip

```bash
# 安装pip
$ sudo apt install python3-pip
```

安装sslocal

```bash
# 安装shadowsocks
$ sudo pip3 install shadowsocks

# sslocal -c ~/shadowsock/conf/path
```

## 挂载备份的目录

```bash
# 查看本机的分区表
$ sudo fdisk -l 

# 找到相应的分区挂在到对应的目录
$ mount /dev/sd<你的分区号a/b/c...> /mnt/home_back

# 改变目录的所属的用户，要不然在拷贝的时候每次都需要改
$ sudo chown 用户名:用户组 -R /mnt/home_back
```

## 恢复vim+tmux

```bash
# clone dotfile
$ git clone git@github.com:codingted/dotfiles.git ~/.dotfiles
```
### 配置vim

```bash
# 设置`.vimrc`软链接
$ ln -s ~/.vimrc ~/.dotfiles/vim/vimrc

# 配置vundle（[vundle.vim](https://github.com/VundleVim/Vundle.vim)）
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# 打开vim，输入:PluginInstall, 等待安装完成
```

### 配置tmux

```bash
# 配置`.tmux.conf`软链接(就可以恢复了)
$ ln -s ~/.tmux.conf ~/.dotfiles/tmux/tmux.conf
```

## 其它工具

### google拼音输入法

虽然sogou输入法更加适合中国人的输入习惯，但是安装起来比较麻烦而且适配的也不太稳定，所以直接就安装google的了

```bash
# 安装fcitx
$ sudo apt-get install fcitx fcitx-googlepinyin im-config

# 配置输入法(选择fcitx为默认的输入法框架)
$ im-config

```
### Shutter(截图工具)

```bash
# Shutter 截屏工具
$ sudo apt-get install shutter

$ shutter -s    # 选择区域截图
$ shutter -a    # 截取活动区域
$ shutter -w    # 截取窗口
$ shutter -f    # 截取真个屏幕
```
### okular(PDF阅读)

```bash
$ sudo apt-get install okular
```
### oh-my-zsh(终极shell)

[oh my zsh install](http://www.codingted.com/2017/06/18/oh_my_zsh_install.html)

### task(todoList)

```bash
# 安装
$ sudo apt  install taskwarrior

# 历史的任务
$ cp -r /mnt/home_back/home/zl/.task* ~/
```

### nodejs(node相关环境)

```bash
$ sudo apt install nodejs
$ sudo apt install npm
```

### youtube_dl(下载youtube视频的工具)

```bash
$ sudo apt install youtube_dl
```

### idea快捷键冲突

```bash
# 修改完立即生效
$ gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['']"
$ gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['']"
```
