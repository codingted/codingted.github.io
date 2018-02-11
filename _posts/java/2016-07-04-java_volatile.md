---
title:  "java volatile 关键字"
categories: java
tags: core_java
comments: true
---

# volatile关键字两种特性

1. 线程可见性:当一个线程修改了被 volatile 修饰的变量后,无论是否加锁, 其它线程都可以立即看到最新的修改,而普通变量却做不到这点;
2. 禁止指令重排序优化,普通的变量仅仅保证在该方法的执行过程中所有依赖 赋值结果的地方都能获取正确的结果,而不能保证变量赋值操作的顺序与程
序代码的执行顺序一致。举个简单的例子说明下指令重排序优化问题:

```java
public class Singleton {
    private static Singleton instance; //避免指令重排声明成 volatile
    private Singleton (){}

    public static Singleton getSingleton() {
      if (instance == null) {                         
          synchronized (Singleton.class) {
              if (instance == null) {       
                  instance = new Singleton(); //指令重排，导致instance为null判断出错
              }
          }
      }
      return instance;
    }

}
```

<!-- more -->

> new 创建对象的过程：
>>1. 给 singleton 分配内存  
>>2. 调用 Singleton 的构造函数来初始化成员变量，形成实例   
>>3. 将singleton对象指向分配的内存空间（执行完这步 singleton才是非 null 了）  
>
> 因为JVM 的即时编译器中存在指令重排序的优化。也就是说上面的第2步和第3步的顺序是不能保证的，最终的执行顺序可能是 1-2-3 也可能是 1-3-2。如果是后者，则在 3 执行完毕、2 未执行之前，被线程二抢占了，这时 instance 已经是非 null 了（但却没有初始化），所以线程二会直接返回 instance，然后使用，然后顺理成章地报错。为避免指令重排需要將*instance*声明为volatile

# 内存中变量的操作

![内存模型]({{ site.img_server }}/java/java_volatile.jpg)

JAVA 内存模型定义了八种操作来完成主内存和工作内存的变量访问,具体
如下:
1. lock:主内存变量,把一个变量标识为某个线程独占的状态;
2. unlock:主内存变量,把一个处于锁定状态变量释放出来,被释放后的变量
才可以被其它线程锁定;
3. read:主内存变量,把一个变量的值从主内存传输到线程的工作内存中,以
便随后的 load 动作使用;
4. load:工作内存变量,把 read 读取到的主内存中的变量值放入工作内存的
变量拷贝中;
5. use:工作内存变量,把工作内存中变量的值传递给 java 虚拟机执行引擎,
每当虚拟机遇到一个需要使用到变量值的字节码指令时将会执行该操作;
6. assign:工作内存变量,把从执行引擎接收到的变量的值赋值给工作变量,
每当虚拟机遇到一个给变量赋值的字节码时将会执行该操作;
7. store:工作内存变量,把工作内存中一个变量的值传送到主内存中,以便
随后的 write 操作使用;
8. write:主内存变量,把 store 操作从工作内存中得到的变量值放入主内存
的变量中。
