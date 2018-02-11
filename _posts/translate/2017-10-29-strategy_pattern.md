---
title:  "策略模式"
categories: translate
tags: 设计模式
comments: true
---

## 动机

有些情况下类之间只是某些行为不同,这时隔离他们之间不同的算法逻辑到不同的类,这样在运行时选择不同的类(算法逻辑)就可以了.

## 模式

定义一系列算法,分别封装到不同类中,并提供相同的调用接口.不同的策略可以单独进行单独调用.

**继承关系**

![strategy_implementation_-_uml_class_diagram]({{ site.img_server }}/translate/strategy_implementation_-_uml_class_diagram.gif)

<!-- more -->

Strategy - 为不同的策略算法定义一个的接口.不同的业务通过接口调用不同的算法逻辑实现类.

ConcreteStartegy - 实现不同策略逻辑实体类.

Context - 包含一个策略类的引用,定义了一个设置策略类引用的方法.Context包含了一个具体的将被用到的ConcreteStartegy,在具体被使用时Context是不关心ConcreteStartegy的具体实现,只是调用Stratege的对外接口.如果需要的话可以定义其它的对象通过Context对象传入工strategy实现类使用.

Context对象接收客户端的请求并且作为客户端的代理对象调用策略对象.通常策略实现类(ConcreteStartegy)是由客户端创建并传递给Context对象.这种情况下Client对象只是和Context对象进行交互.

## 应用实例

**机器人实例**

![strategy_example_robot_-_uml_class_diagram]({{ site.img_server  }}/translate/strategy_example_robot_-_uml_class_diagram.gif)

这个实例是模仿机器人交互的例子程序.开始先创建一个模拟机器人交互的竞技场.包括以下类:

* **IBehaviour(strategy)** - 定义机器人行为的接口.

* **ConcreteStartegy** - AggressiveBehaviour, DefensiveBehaviour, NormalBehaviour;每一个实现类都定义了一种具体的行为.机器人可以根据传感器传来的具体的信息,如:位置,障碍物,等等,来选择具体的行为.

* **Robot** - 机器人是Context类.他保存(获取)相关的位置,障碍物等信息.并且传递这些信息给策略类.

在这个程序中会创建多个机器人并创建不同的行为.每一个机器人被指派不同的行为:"Big Robot"是一个好斗的(aggressive)机器人,袭击它发现的其它机器人."George V.2.1":是一个胆小的机器人当遇到其它的机器人会朝相反的方向跑开."R2":是一个平静的机器人,忽视所有其它机器人.在某些时候机器人的行为会做出相应的变化.

```java

public interface IBehaviour {
    public int moveCommand();
}

public class AgressiveBehaviour implements IBehaviour{
    public int moveCommand()
    {
        System.out.println("\tAgressive Behaviour: if find another robot attack it");
        return 1;
    }
}

public class DefensiveBehaviour implements IBehaviour{
    public int moveCommand()
    {
        System.out.println("\tDefensive Behaviour: if find another robot run from it");
        return -1;
    }
}

public class NormalBehaviour implements IBehaviour{
    public int moveCommand()
    {
        System.out.println("\tNormal Behaviour: if find another robot ignore it");
        return 0;
    }
}

public class Robot {
    IBehaviour behaviour;
    String name;

    public Robot(String name)
    {
        this.name = name;
    }

    public void setBehaviour(IBehaviour behaviour)
    {
        this.behaviour = behaviour;
    }

    public IBehaviour getBehaviour()
    {
        return behaviour;
    }

    public void move()
    {
        System.out.println(this.name + ": Based on current position" +
                "the behaviour object decide the next move:");
        int command = behaviour.moveCommand();
        // ... send the command to mechanisms
        System.out.println("\tThe result returned by behaviour object " +
                "is sent to the movement mechanisms " + 
                " for the robot '"  + this.name + "'");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}


public class Main {

    public static void main(String[] args) {

        Robot r1 = new Robot("Big Robot");
        Robot r2 = new Robot("George v.2.1");
        Robot r3 = new Robot("R2");

        r1.setBehaviour(new AgressiveBehaviour());
        r2.setBehaviour(new DefensiveBehaviour());
        r3.setBehaviour(new NormalBehaviour());

        r1.move();
        r2.move();
        r3.move();

        System.out.println("\r\nNew behaviours: " +
                "\r\n\t'Big Robot' gets really scared" +
                "\r\n\t, 'George v.2.1' becomes really mad because" +
                "it's always attacked by other robots" +
                "\r\n\t and R2 keeps its calm\r\n");

        r1.setBehaviour(new DefensiveBehaviour());
        r2.setBehaviour(new AgressiveBehaviour());

        r1.move();
        r2.move();
        r3.move();
    }
}
```

## 问题

* **策略模式参数的输入输出**

通常策略方法需要从Context中输入参数并返回处理后的结果数据.实现这种需求有两种方式:

* 创建其它的类来包装需要返回的数据
* 将Context对象作为参数传递给策略方法.策略类可以直接设置Context所需要的数据.

当传递数据时需要分析这两种方法的优缺点.例如,如果使用额外的类来封装参数,需要特别留意这个类应该包含哪些字段.或许基于现在继承关系我们加入了所有我们需要的字段,但是在将来我们需要实现其他的策略类时会发现需要添加额外的字段,另外一种情况是:一些策略根本不需要传入额外的类来作为参数.

另一方面,如果我们将Context作为参数传递给策略类,那么策略类和Context将紧紧的耦合在一起.

* **相关算法**

策略模式可以被定义为一个类的继承体系,为应用程序提供扩展不同行为的能力.在这一点上我们可能需要考虑使用组合设计模式.

* **可选的策略实现**

策略模式中使Context包含默认执行的算法(策略)也是可以的,在运行时由Context检查是否存在策略对象,如果不存在就就执行默认的策略,如果找到了策略对象则执行默认策略对象的策略方法代替默认方法.这种方法解决了只有需要特定的策略方法时才有必要实现策略类,否则便不需要考虑策略方法.

* **策略模式和创建(creation)型模式**

在传统的策略模式中客户端程序需要关注策略实现类,为了將客户端程序和策略类代码解耦我们可以在Context队形中使用工厂类来创建策略类.通过这种方法客户端只需要传递相应的参数来请求使用特定的策略算法.

* **策略模式和桥接模式**

两种模式有相同的UML图,但是他们之间的目的不同,策略模式侧重的是行为,而桥接模式侧重的是结构.更进一步说,Context和策略类之间要比桥接模式中的抽象类和实现类耦合的更紧密.

## 总结

策略模式將不同的行为分割到不同的类中.这种做法有它的有点,但是它主要的缺点是客户端必须要了解不同策略之间的差异.因为客户端不需要了解实现细节所以在客户端变化和行为相关时使用策略模式.

原文地址:[http://www.oodesign.com/strategy-pattern.html](http://www.oodesign.com/strategy-pattern.html)
