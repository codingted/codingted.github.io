---
title: Linux 任务记录工具--Taskwarrior
categories: tools
tags: Linux TODO 
comments: true
---

## 介绍

linux 下的记录任务的工具,可以进行查询,打标签,设置优先级,...多种条件过滤.


<!-- more -->


## 命令格式

task [ <filter> ] [<command> ] [ <modifications> | <miscellaneous> ]

## 常用命令

```shell
$ task add Read Taskwarrior documents later
$ task add priority:H Pay bills
$ task next
$ task 2 done
$ task
$ task 1 delete
$ task add Pay the rent due:eom
$ task 12 modify due:eom
$ task 12 modify due:

$ task add "Five syllables here
Seven more syllables there
Are you happy now?"

$ task project: list
```

<!-- more -->

### Project
```shell
$ task project:OLDNAME modify project:NEWNAME
$ task project:OLDNAME and status:pending modify project:NEWNAME

# project hierachy count
$ task add project:Work.Ted ted first
$ task add project:Work.zl zl first

$ task projects
```

### Tags

```shell
$ task +home list
$ task -home list
$ task tags.any: list
$ task tags.none: list
$ task +tag1 and +tag2 [list]
$ task +tag1 or +tag2 [list]
# only have one tag
$ task +tag1 xor +tag2 [list]

```
