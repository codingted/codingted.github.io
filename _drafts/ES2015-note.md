---
layout: post
title:  jekyll相关
categories: jekyll
tags:  jekyll
---

* content
{:toc}

## 结束jekyll进程

ps aux |grep jekyll |awk '{print $2}' | xargs kill -9

## 后台运行jekyll进程

nohup jekyll serve&
