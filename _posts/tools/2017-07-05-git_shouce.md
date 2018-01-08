---
layout: post
title: Git速查手册
category: tools
tags: Git
---

* content
{:toc}

# git 速查手册

## ssh key

> Git 服务器授权使用 SSH 公钥

## Git仓库

### 工作目录初始化仓库

```
$ git init
```
### 从现有仓库克隆clone

```
$ git clone git@github.com:codingted/codingted.github.io.git
```
## Git配置

```
$ git config  user.name "xx"
$ git config  user.email "xx@gmail.com"
# 修改配置
$ git config -e
或者
$ vi .git/config
```

## Git 关联远程仓库

```
$ git remote add [shortname] [url]

# 显示所有远程仓库
$ git remote -v

# 显示某一个远程仓库的信息(远程分支，本地分支和远程分支的关联)
$ git remote show [shortname]

# 删除远程仓库的关联信息
$ git remote rm [shortname]
```
> 本地仓库关联多个远程仓库，在提交时需要指定远程仓库   
> 另外当本地有多个git仓库需要管理多个ssk-key,见本文：
> [多Github账户SSH-Key配置](http://www.codingted.com/2017/06/21/Multi_ssh-key_Git/)

## git本地仓库图示

![本地仓库图示]({{ site.img_server }}/tools/img/git-basic-usage.svg)

## 增加/删除

```
# 添加指定文件到暂存区
$ git add [file1] [file2] ...

# 添加指定目录到暂存区，包括子目录
$ git add [dir]

# 添加当前目录的所有文件到暂存区
$ git add .

# 添加每个变化前，都会要求确认
# 对于同一个文件的多处变化，可以实现分次提交
$ git add -p

# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...

# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]

# 改名文件，并且将这个改名放入暂存区
$ git mv [file-original] [file-renamed]
```
## 代码提交

```
# 提交暂存区到仓库区
$ git commit -m [message]

# 提交暂存区的指定文件到仓库区
$ git commit [file1] [file2] ... -m [message]

# 提交工作区自上次commit之后的变化(已经在仓库中的文件)，直接到仓库区
$ git commit -a

# 提交时显示所有diff信息
$ git commit -v

# 使用一次新的commit，替代上一次提交
# 如果代码没有任何新变化，则用来改写上一次commit的提交信息
$ git commit --amend -m [message]

# 重做上一次commit，并包括指定文件的新变化
$ git commit --amend [file1] [file2] ...
```

## 查看提交历史

```
$ git log

# 展开每次的内容差异并指定最近的x次提交的历史
$ git log -p -2

# 只显示修改的文件及修改的行数
$ git log --stat

# 显示所有提交过的用户，按提交次数排序
$ git shortlog -sn

# 显示指定文件是什么人在什么时间修改过
$ git blame [file]

# 显示文件的修改历史（包含文件的修改内容）
$ git log -p fileName

# 显示暂存区和工作区的差异
$ git diff

# 显示暂存区和上一个commit的差异
$ git diff --cached [file]

# 显示工作区与当前分支最新commit之间的差异
$ git diff HEAD

# 显示两次提交之间的差异
$ git diff [first-branch]...[second-branch]

# 显示今天你写了多少行代码
$ git diff --shortstat "@{0 day ago}"

# 显示某次提交的元数据和内容变化
$ git show [commit]

# 显示某次提交发生变化的文件
$ git show --name-only [commit]

# 显示某次提交时，某个文件的内容
$ git show [commit]:[filename]

# 显示当前分支的最近几次提交
$ git reflog
```

### git --pretty 参数

| 选项     | 说明     |
| :------------- | :------------- |
|%H   | 提交对象（commit）的完整哈希字串 |
|%h   | 提交对象的简短哈希字串 |
|%T   | 树对象（tree）的完整哈希字串  |
|%t   | 树对象的简短哈希字串  |
|%P   | 父对象（parent）的完整哈希字串  |
|%p   | 父对象的简短哈希字串  |
|%an  | 作者（author）的名字 |
|%ae  | 作者的电子邮件地址 |
|%ad  | 作者修订日期（可以用 -date= 选项定制格式） |
|%ar  | 作者修订日期，按多久以前的方式显示 |
|%cn  | 提交者(committer)的名字 |
|%ce  | 提交者的电子邮件地址  |
|%cd  | 提交日期  |
|%cr  | 提交日期，按多久以前的方式显示 |
|%s   | 提交说明  |

```
# 单行显示
$ git log --pretty=oneline

# 更详细的日期信息
$ git log --pretty=format:"%h - %an, %ar : %s"

# 添加 --graph 显示分支分支衍合
$ git log --pretty=format:"%h %s" --graph

# 统计个人代码
git log --author="codingted" --pretty=format:"%cd : %s" 
```
## 分支

```
# 列出所有本地分支
$ git branch

# 列出所有远程分支
$ git branch -r

# 列出所有本地分支和远程分支
$ git branch -a

# 新建一个分支，但依然停留在当前分支
$ git branch [branch-name]

# 新建一个分支，并切换到该分支
$ git checkout -b [branch]

# 新建一个分支，指向指定commit
$ git branch [branch] [commit]

# 新建一个分支，与指定的远程分支建立追踪关系
$ git branch --track [branch] [remote-branch]

# 切换到指定分支，并更新工作区
$ git checkout [branch-name]

# 切换到上一个分支
$ git checkout -

# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]

# 合并指定分支到当前分支
$ git merge [branch]

# 选择一个commit，合并进当前分支
$ git cherry-pick [commit]

# 删除分支
$ git branch -d [branch-name]

# 删除远程分支
$ git push origin --delete [branch-name]
$ git branch -dr [remote/branch]
```

## 标签

```
# 列出所有tag
$ git tag

# 新建一个tag在当前commit
$ git tag [tag]

# 新建一个tag在指定commit
$ git tag [tag] [commit]

# 删除本地tag
$ git tag -d [tag]

# 删除远程tag
$ git push origin :refs/tags/[tagName]

# 将本地分支推送到远程
$ git push origin localName:remoteName

# 查看tag信息
$ git show [tag]

# 提交指定tag
$ git push [remote] [tag]

# 提交所有tag
$ git push [remote] --tags

# 新建一个分支，指向某个tag
$ git checkout -b [branch] [tag]
```

## 远程拉取提交

```
# 取回远程仓库的变化，并与本地分支合并
$ git pull [remote] [branch]

# 上传本地指定分支到远程仓库
$ git push [remote] [branch]

# 强行推送当前分支到远程仓库，即使有冲突
$ git push [remote] --force

# 推送所有分支到远程仓库
$ git push [remote] --all
```
## 撤销/回滚

```
# 恢复暂存区的指定文件到工作区
$ git checkout [file]

# 恢复某个commit的指定文件到暂存区和工作区
$ git checkout [commit] [file]

# 恢复暂存区的所有文件到工作区
$ git checkout .

# 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变
$ git reset [file]

# 重置暂存区与工作区，与上一次commit保持一致
$ git reset --hard

# 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
$ git reset [commit]

# 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
$ git reset --hard [commit]

# 重置当前HEAD为指定commit，但保持暂存区和工作区不变
$ git reset --keep [commit]

# 新建一个commit，用来撤销指定commit
# 后者的所有变化都将被前者抵消，并且应用到当前分支
$ git revert [commit]

# 暂时将未提交的变化移除，稍后再移入
$ git stash
$ git stash pop

# 备份当前工作区并添加备注
$ git stash save "message"

# 清空栈
$ git stash clear
```

## 小技巧

* 配置.gitignore规则不生效

在项目开发过程中需要把已经纳入版本控制的文件忽略,直接配置`.gitignore`无法生效,原因是`.gitignore`只能忽略未被纳入版本控制的文件,如果已经纳入版本控制的需要忽略则需要先把本地的缓存清除掉

```
$ git rm -r --cached .(这是清除本地所有的当然也能指定某个文件)
$ git rm -r --cached [file]
$ git add .
$ git commit -m 'update gitignore'

```



# 参考链接

[阮一峰的博客/常用Git命令](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)   
[码云](http://git.oschina.net/progit/index.html)    
[图解Git](http://marklodato.github.io/visual-git-guide/index-zh-cn.html)    
