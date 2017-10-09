---
layout: post
title:  "面向对象设计原则"
categories: translate
tags: 设计模式
comments: true
---

* content
{:toc}


# 设计原则
-----------

## 什么是软件设计原则

>软件设计原则提供了一系列的指导原则帮助我们避免坏的设计,设计原则被[Robert Martin](https://en.wikipedia.org/wiki/Robert_Cecil_Martin)整理在"敏捷软件开发:原则,模式,实践"一书中.根据Robert Martin 在书中的描述,坏的设计的3个特质应该被避免:

* 不易变(Rigidity) - 改变现有的程序是困难的,每一个改变將影响系统其它部分的改变.
* 脆弱(Fragility) - 当你改变某一个部分时,会导致系统其它部分意想不到的错误.
* 固定(Immobility) - 只能服务于当前系统,不能被其它系统很好的复用.







### 开闭原则(Open Close Principle)

> 软件的类,模块,方法应该**open for extension**但是**closed for modification**(对扩展开放对修改关闭)

OPC是一个通用原则.在写代码的过程中你应该确保当你需要扩展你的类时,你不会修改原有的类.相应的模块,库文件也应该遵循该原则.假如你对外提供了一个工具代码库,里边包含了一系列的类,那么现在你不应该改动原来的代码,只应该在原来代码的基础上进行扩展(提供向下兼容和回归测试).这就是为什么我们要遵循OPC.

当提及类之间开闭原则,我们应该确保我们使用的是抽象类,实体类实现了它的一系列的行为(方法).这就要求实体类继承抽象类而不是改变它们.具体的如模板模式(Template),策略模式(Strategy).

### 依赖倒置原则(Dependency Inversion Principle)

> 高层模块不应该依赖低层模块.双方都应该依赖抽象.    
> 抽象不应该依赖细节.细节应该依赖抽象.

依赖倒置原则声明我们要將高层模块和低层模块解耦,在高层类和低层类之间引入了抽象层.使用细节依赖抽象而不是抽象依赖细节(依赖倒置).

依赖倒置(控制反转),就是模块之间的依赖关系.常见的在软件设计中模块(类,方法...)需要其它的模块,在当前模块初始化并持有地方放模块的直接引用,这样让两个模块紧紧的联系在了一起.为了使模块之间解耦,第一个模块应该提供一个钩子(属性,参数...),外部控制模块將被引用模块注入到第一个模块当中.

通过依赖倒置可以轻松改变模块之间的依赖关系.工厂模式(Factories)和抽象工程(Abstract Factories)可以被用来做外部控制框架,还有特殊的我们称之为控制反转容器(spring).

### 接口隔离原则(Interface Segregation Principle)

> 类不应该被强制依赖他们不需要的接口功能.

该原则让我们明白如何创建我们的接口.当我们创建我们的接口类时我们要注意接口中的每个方法是否应该被放在该接口中(明确职责).如果我们放了一个本不属于该接口的方法,那么我们在进行继承时,就不得不实现这个方法.例如我们创建了一个Worker接口并且添加了一个lunch方法,所有的Worker都需要实现lunch方法.但是如果我们的Worker是一个机器人呢?

如果一个接口包含了它不应该具有的方法我们说改接口被污染了(polluted)或者是胖接口(fat interfaces),我们应该避免这种情况.

### 单一职责原则(single Responsibility Principle)

> 只有一个原因导致类被更改

职责可以看成是类被更改的原因(a responsibility is considered to be one reason to change).这个原则阐明了如果我们有两个原因改变一个类,纳闷我们应该將该类分解成2个类.每一个类紧紧处理一种职责,后续如果因为某种原因(职责)而需要修改,我们修改相应的类就可以了.如果一个类拥有了多种职责,那么很可能我们在因为一种原因修改类时影响其它的功能.

单一职责原则是由Tom DeMarco在他的书 Structred Analysis and Systems Specification, 1979.Robert Martin 重新诠释了这一概念,并将责任界定为改变的理由.

### 李氏替换原则(Liskov's Substitution Principle)

> 派生类型可以被替换为父类型

该原则可以看做开闭原则在行为方面的特别说明,我们必须保证可以將派生类型替换为父类型而不改变原来代码的行为.新的派生类型被替换为父类而不引起代码的其它改变.

李氏替换原则由Barbara Liskov在1987年的Object Oriented Programing Systems Languages and Applications 会议上首先提出.[数据抽象和继承](https://dl.acm.org/citation.cfm?id=62141)

原文链接:[http://www.oodesign.com/open-close-principle.html](http://www.oodesign.com/open-close-principle.html)
