---
layout: post
title:  "模板方法"
categories: translate
tags: 设计模式
comments: true
---

* content
{:toc}

## 动机

模板方法就是提前写好通用的部分,不用在每个需要使用的地方再重新创建(保证了代码的简洁和可维护性).模板方法是基础,可以声明为抽象操作,由子类提供具体的实现.

## 示意

> * 定义操作的框架,具体的实现由子类来完成.
> * 模板方法允许子类重写其中某些步骤的具体操作过程,但是有模板类定义的整体过程是不允许进行修改的.

![template_method_implementation_-_uml_class_diagram.gif]({{ site.img_server }}/translate/img/template_method_implementation_-_uml_class_diagram.gif)







## 实现

AbstractClass - 定义基本的操作及步骤实现类具体定义操作的具体实现.
templateMethod() - 实现操作的基本的框架(方法的调用顺序及操作顺序).模板方法调用定义在AbstractClass或者是ConcreteClass中的方法.
ConcreteClass - 实现定义在模板类中的具体的方法,完成实体类所要实现的功能.

当实现类调用模板方法时,模板方法将会调用实现类中具体的方法实现执行相应的操作,完成该类的特定的功能.

## 例子

适用场景:

* 模板方法中实现逻辑中不变的部分,实现类根据自己的要求实现可变的部分.
* 当进行重构时一些公用的模板代码需要提取到抽象类(或父类)中,这样可以避免相同代码重复出现在多个地方.

例子- 旅游代理

![template_method_example_trips_-_uml_class_diagram.gif]({{ site.img_server }}/translate/img/template_method_implementation_-_uml_class_diagram.gif)

假设我们要为旅游代理商开发一套应用程序.旅游代理商需要管理每一个旅行.所有的旅行都包含一些相同的行为部分.但是提供了不同的服务套餐.例如每个旅行都包含以下的基本的步骤:

1. 旅客被送到指定的旅游目的地,通过飞机,火车,轮船...
2. 每一天旅客都要访问一些地方.
3. 返回.

现在我们创建一个抽象类包含:上述每一步的抽象方法,一个构造函数,一个按照我们定义的步骤调用每一个抽象方法的final方法.

下面是我们实现的抽象类

```java
public class Trip {
    public final void performTrip(){
        doComingTransport();
        doDayA();
        doDayB();
        doDayC();
        doReturningTransport
    }
    public abstract void doComingTransport();
    public abstract void doDayA();
    public abstract void doDayB();
    public abstract void doDayC();
    public abstract void doReturningTransport();
    }

    public class PackageA extends Trip {
        public void doComingTransport() {
            System.out.println("The turists are comming by air ...");
        }
        public void doDayA() {
            System.out.println("The turists are visiting the aquarium ...");
        }
        public void doDayB() {
            System.out.println("The turists are going to the beach ...");
        }
        public void doDayC() {
            System.out.println("The turists are going to mountains ...");
        }
        public void doReturningTransport() {
            System.out.println("The turists are going home by air ...");
        }
    }
    public class PackageB extends Trip {
        public void doComingTransport() {
            System.out.println("The turists are comming by train ...");
        }
        public void doDayA() {
            System.out.println("The turists are visiting the mountain ...");
        }
        public void doDayB() {
            System.out.println("The turists are going to the beach ...");
        }
        public void doDayC() {
            System.out.println("The turists are going to zoo ...");
        }
        public void doReturningTransport() {
            System.out.println("The turists are going home by train ...");
        }
}
```

## 问题及解决方案

**实现类作为模板方法类**

父类不一定是抽象类也可以是包含模板方法的实现类,这种情况下基本操作的方法都有一个默认的实现,这种方法的缺陷是子类不知道具体哪个方法需要被重写.
仅当实现自定义钩子才应使用具体基类.

**模板方法不应该被重写**

子类不能重写继承的模板方法,应该使用特定的编程语言的修饰符来确保这一点.

**定制钩子**

模板方法的一个特殊例子即使钩子方法.钩子方法在基类中被声明为一个空的方法,但是可以被子类实现.定制钩子可以被认为是模板方法的一个特例,也是一种完全不同的机制.
通常子类可以通过覆盖父类方法,并显示调用父类方法来扩展方法.

```java
class Subclass extends Superclass
{
    ...
        void something() {
            // some customization code to extend functionality
            super. something ();
            // some customization code to extend functionality
        }
}
```

不幸的是人们很容易忘记显示的调用父类的方法,这迫使开发人员去检查父类中的代码.除了重写还可以增加一些钩子方法.这样子类只需要实现钩子方法而不需要关注其它的方法.

```java

class Superclass
{
    ...
    protected void preSomethingHook(){}
    protected void postSomethingHook(){}
    void something() {
        preSomethingHook();
        // something implementation
        postSomethingHook();
    }
}
class Subclass extends Superclass
{
    protected void preSomethingHook()
    {
        // customization code
    }
    protected void postSomethingHook()
    {
        // customization code
    }
}
```

**尽量少的基本方法被重写**

在运用模板方法模式进行设计时,尽量少的被重写的基本方法可以使实现子类更清晰和更容易.

**命名约定**

为了识别需要被实现的方法,最好使用特定的命名约定.例如使用"do"前缀.类似的定制的钩子可以使用"pre"和"post"前缀.

**抽象方法的使用**

当我们需要在基类中包含一些默认的代码,但是另一方面子类中需要继承该方法,这时候应该分成两个方法:一个抽象方法,一个实现方法.我们不能依赖子类会在重写该方法时调用父类的方法.就像这样:

```java
void something() {
    super. something ();
    // extending the method
}
```

**模板方法还是策略模式**

策略模式包含了模板方法模式.区别在于策略模式使用委托,但是模板方法使用继承.

## 热点

模板方法使用了控制反转的结构,类似于"好莱坞原则":从基类的角度来看可以理解为:"别联系我,需要的时候我会联系你"(Dont't call us, we'll call you".).方法的调用不是通过子类完成的,而是通过基类的模板方法调用到子类的具体实现.

由于上述原因,我们应该特别注意模板方法的访问修饰符:模板方法应该在基类中被实现,而具体的业务需要在子类中实现.定制钩子方法是一个特殊的情况.


原文地址:[http://www.oodesign.com/template-method-pattern.html]http://www.oodesign.com/template-method-pattern.html
