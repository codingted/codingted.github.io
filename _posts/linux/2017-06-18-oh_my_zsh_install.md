---
title: oh my zsh install
categories: linux
tags: shell
comments: true
---

## Basic install

```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
apt install zsh
```
<!-- more -->

## Manul install

```
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

cp ~/.zshrc ~/.zshrc.orig

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

chsh -s /bin/zsh
```

[From](https://github.com/robbyrussell/oh-my-zsh/)
