---
title: Git速查手册
category: tools
tags: Git
---

# git 速查手册

## ssh key

> Git 服务器授权使用 SSH 公钥

## Git仓库

### 工作目录初始化仓库

```
$ git init
```
### 从现有仓库克隆clone

```shell
$ git clone git@github.com:codingted/codingted.github.io.git
```
## Git配置

```shell
$ git config  user.name "xx"
$ git config  user.email "xx@gmail.com"
# 修改配置
$ git config -e
或者
$ vi .git/config
```

## Git 关联远程仓库

```shell
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
> [多Github账户SSH-Key配置]({{ site.url }}/2017/06/21/Multi_ssh-key_Git/)

## git本地仓库图示

![本地仓库图示]({{ site.img_server }}/tools/git-basic-usage.svg)

## 增加/删除

```shell
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

```shell
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

```shell
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

# 显示包含指定关键字的提交
$ git log --grep 

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

```shell
# 单行显示
$ git log --pretty=oneline

# 更详细的日期信息
$ git log --pretty=format:"%h - %an, %ar : %s"

# 添加 --graph 显示分支衍合
$ git log --pretty=format:"%h %s" --graph

# 统计个人代码
git log --author="codingted" --pretty=format:"%cd : %s" 
```
## 分支

```shell
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

```shell
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

```shell
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

```shell
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

# 使用栈中哪一个信息
$ git stash apply 

# 清空栈
$ git stash clear
```

## 小技巧

* 配置.gitignore规则不生效

在项目开发过程中需要把已经纳入版本控制的文件忽略,直接配置`.gitignore`无法生效,原因是`.gitignore`只能忽略未被纳入版本控制的文件,如果已经纳入版本控制的需要忽略则需要先把本地的缓存清除掉

```shell
$ git rm -r --cached .(这是清除本地所有的当然也能指定某个文件)
$ git rm -r --cached [file]
$ git add .
$ git commit -m 'update gitignore'

```

> **.gitignore文件配置规则**
> 
> 1、空格不匹配任意文件，可作为分隔符，可用反斜杠转义  
> 2、以“＃”开头的行都会被 Git 忽略。即#开头的文件标识注释，可以使用反斜杠进行转义。  
> 3、可以使用标准的glob模式匹配。所谓的glob模式是指shell所使用的简化了的正则表达式。  
> 4、以斜杠"/"开头表示目录；"/"结束的模式只匹配文件夹以及在该文件夹路径下的内容，但是不匹配该文件；"/"开始的模式匹配项目根目录；如果一个模式不包含斜杠，则它匹配相对于当前 .gitignore 文件路径的内容，如果该模式不在 .gitignore 文件中，则相对于项目根目录。  
> 5、以星号"*"通配多个字符，即匹配多个任意字符；使用两个星号"**" 表示匹配任意中间目录，比如a/**/z可以匹配 a/z, a/b/z 或 a/b/c/z等。  
> 6、以问号"?"通配单个字符，即匹配一个任意字符；  
> 7、以方括号"[]"包含单个字符的匹配列表，即匹配任何一个列在方括号中的字符。比如[abc]表示要么匹配一个a，要么匹配一个b，要么匹配一个c；如果在方括号中使用短划线分隔两个字符，表示所有在这两个字符范围内的都可以匹配。比如[0-9]表示匹配所有0到9的数字，[a-z]表示匹配任意的小写字母）。  
> 8、以叹号"!"表示不忽略(跟踪)匹配到的文件或目录，即要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。需要特别注意的是：如果文件的父目录已经被前面的规则排除掉了，那么对这个文件用"!"规则是不起作用的。也就是说"!"开头的模式表示否定，该文件将会再次被包含，如果排除了该文件的父级目录，则使用"!"也不会再次被包含。可以使用反斜杠进行转义。  

```shell
#               表示此为注释,将被Git忽略
*.log:          表示忽略所有 .log 文件
!lib.a          表示但lib.a除外
/TODO           表示仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
build/          表示忽略 build/目录下的所有文件，过滤整个build文件夹；
doc/*.txt       表示会忽略doc/notes.txt但不包括 doc/server/arch.txt
fd1/*           忽略目录 fd1 下的全部内容，但保留该目录

!.gitignore
```

* 查看HEAD指针在各个分支的移动轨迹

```shell
$ git reflog 

# 如果想撤回merge的内容那么ORIG_HEAD所指的就是合并之前的节点
$ git reset --hard ORIG_HEAD
```



# 参考链接

[阮一峰的博客/常用Git命令](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)   
[码云](http://git.oschina.net/progit/index.html)    
[图解Git](http://marklodato.github.io/visual-git-guide/index-zh-cn.html)    
