---
layout: post
title:  "开闭原则"
categories: translate
tags: 设计模式 设计原则
comments: true
---

* content
{:toc}

## 动机

一个良好的系统设计需要考虑到编码阶段以及维护阶段频繁的更改.通常添加一个新功能可能引起许多的更改.应该尽量避免在原来的代码上做过多的改动,因为原来的代码可能已经经过单元测试,如果现在修改原来的代码可能会导致已有功能出现错误.

开闭原则阐述了在添加新功能时尽量少的改动现有的功能代码.而是通过添加新的类来保证现有代码尽可能少的更改.

> 总得来说是:软件中的实体(类,模块,方法)应该是 **对扩展开放对修改关闭**





## 例子
### 坏的设计

下边是一个违背开闭原则的例子.不同的形状(shape)通过继承GraphicEditor来进行画图.

![ocp.bad]({{ site.img_server }}/translate/img/opc.bad.gif)

显然这种设计违背了开闭原则,因为当我们需要添加新的形状时都需要修改GraphicEditor类.这种设计有以下几个缺点:

* 添加新的形状需要重新进行单元测试
* 当需要添加新的形状时,开发人员需要了解GraphicEditor类的全部逻辑,这个需要花费的时间成本是相当昂贵的.
* 添加一个新的形状可能会导致其它的副作用,即使现在的形状工作良好.

为了更好的说明问题,我们可以想象一下GraphicEditor是一个很大很大的类,包含了很多的方法,被很多人修改过,但是shape是紧紧由一个开发人员负责.在这个种情况下,如果添加一个新的shape而不需要了解GraphicEditor内部的逻辑这将是一个很大的进步.

```java
// Open-Close Principle - Bad example
 class GraphicEditor {
 
 	public void drawShape(Shape s) {
 		if (s.m_type==1)
 			drawRectangle(s);
 		else if (s.m_type==2)
 			drawCircle(s);
 	}
 	public void drawCircle(Circle r) {....}
 	public void drawRectangle(Rectangle r) {....}
 }
 
 class Shape {
 	int m_type;
 }
 
 class Rectangle extends Shape {
 	Rectangle() {
 		super.m_type=1;
 	}
 }
 
 class Circle extends Shape {
 	Circle() {
 		super.m_type=2;
 	}
 } 
```

### 好的设计

下边是一个遵循了开闭原则的设计.在这个设计中GraphicEditor类中的抽象方法 *draw()*进行绘图的,把该方法的实现移到了具体的类中.使用开闭原则避免了在添加新的shape时修改GraphicEditor.当我们添加一个新的shape时:

* 不需要重写单元测试
* 不需要去了解GraphicEditor类内部的逻辑.
* 因为绘图方法移到了具体的类中,降低了因为修改对其它方法造成的风险.

![ocp.good]({{ site.img_server }}/translate/img/opc.good.gif)

```java
// Open-Close Principle - Good example
 class GraphicEditor {
 	public void drawShape(Shape s) {
 		s.draw();
 	}
 }
 
 class Shape {
 	abstract void draw();
 }
 
 class Rectangle extends Shape  {
 	public void draw() {
 		// draw the rectangle
 	}
 } 
```

## 总结

灵活的设计涉及额外的花费时间和精力，并引入了新的抽象层次，从而增加了代码的复杂性。 所以这个原则应该适用于那些最有可能改变的地区.

有许多设计模式可以帮助我们扩展代码而不改变它。 例如，Decorator模式可帮助我们遵循Open Close原则。 此外，工厂方法和观察者模式也可用于设计易于更改的应用程序，并在现有代码中进行最小更改.

原文链接:[http://www.oodesign.com/open-close-principle.html](http://www.oodesign.com/open-close-principle.html)
