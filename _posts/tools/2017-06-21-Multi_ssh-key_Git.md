---
title: 多Github账户SSH-Key配置
category: tools
tags: ssh-key Github
comments: true
---

## 创建public key

```shell
$ ssh-keygen -t rsa -C "your_email@youremail.com"
```
例如，你创建了两个key

```shell
~/.ssh/id_rsa_codingted
~/.ssh/id_rsa_ted12214
```
然后添加两个key

```shell
$ ssh-add ~/.ssh/id_rsa_codingted
$ ssh-add ~/.ssh/id_rsa_ted12214
```
> 你可以在开始前清除缓存的key   
> $ ssh-add -D

最后你可以检查已经保存的key

```shell
$ ssh-add -l
```

## 修改ssh config

```shell
$ vi ~/.ssh/config
添加如下内容

#codingted  (github 配置)
Host codingted.github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_codingted
    # fixup for openssh 8.8 (有一些需要配置例如阿里云)
    HostKeyAlgorithms +ssh-rsa
    PubkeyAcceptedKeyTypes +ssh-rsa
##codingted  (github 配置)
Host ted12214.github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_ted12214
```

## 克隆仓库并修改Git 配置

* 克隆项目
> 注意克隆项目的地址,与上边定义的Host 相同

```shell
git clone git@codingted.github.com:codingted/xxx.git
```
> 如果先前已经克隆了项目,先在需要重新关联项目

```shell
git remote rm origin
## ssh
git remote add origin git@codingted.github.com:codingted/xxx.git
or
## https
git remote add origin https://codingted.github.com:codingted/xxx.git
```

* 进入仓库目录修改配置

```shell
// 设置github用户名
$ git config user.name "codingted"
$ git config user.email "codingted@gmail.com"
```

现在就可以进行git命令操作了（记得添加ssh key 到github中）

[原文链接地址](https://gist.github.com/jexchan/2351996/)
