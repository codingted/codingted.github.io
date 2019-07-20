---
layout: post
title:  "观察者模式"
categories: translate
tags: 设计模式
comments: true
---

* content
{:toc}

## 责任链模式

### 动机

系统构建过程中可能会有这种情况：一个对象产生的事件会需要其它的对象进行处理。但是有时候我们又无法直接访问需要处理该事件的对象。这种情况有两种解决的方法：有一种简单（懒惰）的方法是将所有的方法设置为`public`或者是创建两者的引用在这里使用责任链模型。

`责任链模式`允许对象发送一个命令而不必要关心具体有多少的个对象处理该命令。命令从一个对象传递到另外一个对象依次类推，使没一个处理对象成为该`链`的一环。最常见的使用责任连模式的是自动售货机投币口：投币口并不是为没中类型的硬币设置一个，机器只有一个投币口。丢硬币的指令被传送到有命令接收器确定的适当的存储位置。

* 这样不需要将发送者和接收者耦合在一起，从而使其它对象可以处理这个请求。
* 对象成为链条的一部分，请求从一个对象发送到另一个对象，直到其中一个对象处理它为止。

## 模式

![chain_of_responsability_implementation]({{ site.img_server }}/translate/img/chain_of_responsability_implementation.gif)





模型参与者

> **Handler** - 定义处理请求的接口
> **RequestHander** - 处理请求（如果可以处理则进行处理否则将请求发送给它的后继者）
> **Client** - 将命令发送给处理链的地一个对象。

责任链模式是如何工作的：`Client`将请求发送给责任链的`Handler`，每一个Handler开始尝试处理接到的请求，处理完成过后传给后一个对象。

以下介绍责任链实施的典型例子：

```java
public class Request {	
    private int m_value;
    private String m_description;

	public Request(String description, int value)
	{
		m_description = description;
		m_value = value;
	}

	public int getValue()
	{
		return m_value;
	}

	public String getDescription()
	{
		return m_description;
	}          
}

public abstract class Handler
{
	protected Handler m_successor;
	public void setSuccessor(Handler successor)
	{
		m_successor = successor;
	}

	public abstract void handleRequest(Request request);
}

public class ConcreteHandlerOne extends Handler
{
	public void handleRequest(Request request)
	{
		if (request.getValue() < 0)
		{           //if request is eligible handle it
			System.out.println("Negative values are handled by ConcreteHandlerOne:");
			System.out.println("\tConcreteHandlerOne.HandleRequest : " + request.getDescription()
						 + request.getValue());
		}
		else
		{
			super.handleRequest(request);
		}
	}
 }

public class ConcreteHandlerThree extends Handler
{
	public void handleRequest(Request request)
	{
		if (request.getValue() >= 0)
		{           //if request is eligible handle it
			System.out.println("Zero values are handled by ConcreteHandlerThree:");
			System.out.println("\tConcreteHandlerThree.HandleRequest : " + request.getDescription()
						 + request.getValue());
		}
        else
		{
			super.handleRequest(request);
		}
	}
}

public class ConcreteHandlerTwo extends Handler
{
	public void handleRequest(Request request)
	{
		if (request.getValue() > 0)
		{           //if request is eligible handle it
			System.out.println("Positive values are handled by ConcreteHandlerTwo:");
			System.out.println("\tConcreteHandlerTwo.HandleRequest : " + request.getDescription()
						 + request.getValue());
		}
        else
		{
			super.handleRequest(request);
		}
	}
}

public class Main 
{
	public static void main(String[] args) 
	{
		// Setup Chain of Responsibility
		Handler h1 = new ConcreteHandlerOne();
		Handler h2 = new ConcreteHandlerTwo();
		Handler h3 = new ConcreteHandlerThree();
		h1.setSuccessor(h2);
		h2.setSuccessor(h3);

		// Send requests to the chain
		h1.handleRequest(new Request("Negative Value ", -1));
		h1.handleRequest(new Request("Negative Value ",  0));
		h1.handleRequest(new Request("Negative Value ",  1));
		h1.handleRequest(new Request("Negative Value ",  2));
		h1.handleRequest(new Request("Negative Value ", -5));	    
	}
}
```
## 适用性和范例

责任链模式适用于以下几种情况：

> * 超过一个对象需要处理一个命令
> * 处理程序不能提前知道
> * 处理程序需要自动确定
> * 请求的命令不必指定请求的接收者
> * 处理命令的一组对象是通过动态的方式声明

**例子1**

设计一个批准购买请求的系统.

在这种情况下购买的请求被分成了不同的类别,每一种拥有自己的审批权限.审批权限应该是可以随时进行设置的,系统应该拥有一种灵活的处理机制来应对相应的场景.

上面例子中的`Client`发送请求需要对应审批权限的回答,该审批机构可以审批该请求或者是将该请求转发到下一个审批机构.

例如，假设要求为购买办公室的新键盘,这个采买请求从办公室主管到部门主管最后由采购部门进行购买.
    
    
    请求是需要被处理的内容,不同的请求对应不同的处理者,有的负责处理鼠标点击事件,有的处理按下'Enter'键按下的事件,有的处理按下'Delete'键的事件,责任链负责处理产生的事件.









































