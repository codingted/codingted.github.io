---
layout: post
title: 多Github账户SSH-Key配置
category: tools
tags: ssh-key Github
---

* content
{:toc}

## 创建public key

```
$ ssh-keygen -t rsa -C "your_email@youremail.com"
```
例如，你创建了两个key

```
~/.ssh/id_rsa_codingted
~/.ssh/id_rsa_ted12214
```
然后添加两个key

```
$ ssh-add ~/.ssh/id_rsa_codingted
$ ssh-add ~/.ssh/id_rsa_ted12214
```
> 你可以在开始前清除缓存的key   
> $ ssh-add -D

最后你可以检查已经保存的key

```
$ ssh-add -l
```

## 修改ssh config

```
$ vi ~/.ssh/config
添加如下内容

#codingted  (github 配置)
Host codingted.github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_codingted
##codingted  (github 配置)
Host ted12214.github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_ted12214
```

## 克隆仓库并修改Git 配置

* 克隆项目
> 注意克隆项目的地址,与上边定义的Host 相同

```
git clone git@codingted.github.com:codingted/xxx.git
```
> 如果先前已经克隆了项目,先在需要重新关联项目

```GIT
git remote rm origin
## ssh
git remote add origin git@codingted.github.com:codingted/xxx.git
or
## https
git remote add origin https://codingted.github.com:codingted/xxx.git
```

* 进入仓库目录修改配置

```
// 设置github用户名
$ git config user.name "codingted"
$ git config user.email "coder.tedzhao@gmail.com"
```

现在就可以进行git命令操作了（记得添加ssh key 到github中）

[原文链接地址](https://gist.github.com/jexchan/2351996/)
