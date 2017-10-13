---
layout: post
title:  "观察者模式
categories: translate
tags: 设计模式
comments: true
---

* content
{:toc}

## 动机

我们不能认为面向对象编程仅仅包含对象而不包含他们的状态.换句话说,面向对象编程是关于对象及他们之间的交互.某个对象需要在另外一个对象变化时被通知,这种情况是很常见的.为了实现一个好的设计我们需要尽量的將对象之间进行解耦来减少他们之间的相互依赖.观察者模式可以被用在当一个主题需要被一个或者多个观察者观察的情况.

假设我们有一个股票系统,该系统为不同类型的客户端系统提供数据.我们现在需要一个web客户端系统来接收股票系统的数据,但是在不久的将来我们还会有手机客户端,手持设备,短息等不同的终端接收方.现在使用观察者模式:我们需要將主题(股票系统)和观察者(不同的数据接收端)分开.

## 模式

在对象之间建立一对多的依赖关系,当被依赖的对象发生变化时,所有依赖对象將收到通知并自动更新自身的状态.

![observer_implementation_-_uml_class_diagram]({{ site.img_server }}/translate/img/observer_implementation_-_uml_class_diagram.gif)

模型参与者

> **Observable** - 定义绑定和解绑观察者的接口或抽象方法.在GOF的书中这个类/接口被成为**主题**(**Subject**)   
> **ConcreteObservable** - 被观察者的实现类.管理着自身的状态,当自身的状态发生变化时通知绑定的**Observers**. 
> **Observer** - 定义通知观察者的方法通常是接口或者抽象类.  
> **ConcreteObserverA,ConcreteObserverB** - **Observer**实现类.

## 适用性&&例子

观察者模式适用于以下场景:
* 一个对象的状态改变需要被放映到其它的对象中,并且这两者之间不存在紧耦合.
* 系统框架在后续功能增强中添加新的观察者不需要进行很大的改动.

一些典型的列子:

* **MVC模式** - 在MVC模式中观察者模式被用来解耦模型层和视图层.视图层是**Observer**模型层是**Observable**
* **事件管理** - 在这个场景中观察者模式被广泛的使用.Swing和.Net采用观察者模式实现事件机制.

### 例子 - 新闻代理商

新闻代理收集新闻并且將收集的新闻发布给不同的订阅者.我们需要为新闻代理商和订阅者创建合理的架构保证新闻可以及时通知到订阅者.订阅者通常是:Emails,SMS,...,我们的架构需要保证扩展的灵活性,可以支持不同的新闻类型和不同的订阅者.

![observer_example_newspublisher_-_uml_class_diagram]({{ site.img_server }}/translate/img/observer_example_newspublisher_-_uml_class_diagram.gif)

NewsPublisher是被观察者(主题),因为需要被扩展为不同类型的主题对象所以NewsPublisher被声明为抽象类.现在只有一个实现类BussinessNewsPublisher后续可能还有SportsNewsPublisher,PoliticalNewsPublisher... .

观察者实现更新的触发逻辑在NewsPublisher中实现,被观察者持有观察者并將最近的新闻通知给不同的观察者.观察者Subscriber有一系列的实现包括:SMSSubscriber, EmailSubscriber,观察者NewsPublisher持有Subscriber对象的引用两者是通过抽象类实现关联的.通过attach和detach方法可以实现观察者的添加或删除.

## 问题

* **主题观察者多对多**

当我们有许多的观察者需要关注超过一个主题,当其中有一个主题的状态发生改变,需要通知到观察者进行相应的状态改变.和一个主题一样我们需要在另外一个主题绑定观察者.

* **谁来触发更新**

通长情况下是由被观察在状态改变时通知观察者进行更新.但是当主题状态更新频繁时,频繁的通知观察者就显得效率低下,这时候可以由观察者在合适的时候进行更新.

* ****






















