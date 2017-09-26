---
layout: post
title:  "java volatile 关键字"
categories: java
tags: core_java
comments: true
---

* content
{:toc}

# 使用场景
ThreadLocal是为每个线程保存了单独的变量副本,在线程内可以安全的访问.

# 示例代码

```
public class Foo
{
    // SimpleDateFormat is not thread-safe, so give one to each thread
    private static final ThreadLocal<SimpleDateFormat> formatter = new ThreadLocal<SimpleDateFormat>(){
        @Override
        protected SimpleDateFormat initialValue()
        {
            return new SimpleDateFormat("yyyyMMdd HHmm");
        }
    };

    public String formatIt(Date date)
    {
        return formatter.get().format(date);
    }
}
```






# 源码分析

ThreadLocal提供一下主要的方法

方法名称                 | 描述
-------------------------|--------------
protected T initialValue()| 为当前线程返回初始变量(在线程第一次调用get时调用此方法,正常情况下该方法只被调用一次)
public void set(T value) | 为当前线程设置本地变量
public T get()           | 获取本地变量副本,如果当前线程还没有set变量副本,则调用initialValue()返回初始变量
public void remove()     | 移除线程变量副本

## set

```
/**
 * Sets the current thread's copy of this thread-local variable
 * to the specified value.  Most subclasses will have no need to
 * override this method, relying solely on the {@link #initialValue}
 * method to set the values of thread-locals.
 *
 * @param value the value to be stored in the current thread's copy of
 *        this thread-local.
 */
public void set(T value) {
    //获取当前线程
    Thread t = Thread.currentThread();
    //获取线程本地变量Map
    ThreadLocalMap map = getMap(t);
    if (map != null)
        //以当前的ThreadLocal变量为key保存变量副本value
        //所以当前线程可以包含不同的ThreadLocal变量为key的键值对
        map.set(this, value);
    else
        //如果本地变量为空则创建本地变量Map
        createMap(t, value);
}
```
![threadLocalMap](www.codingted.com:9090/java/img/threadLocal.jpg)

## get

```
/**
 * Returns the value in the current thread's copy of this
 * thread-local variable.  If the variable has no value for the
 * current thread, it is first initialized to the value returned
 * by an invocation of the {@link #initialValue} method.
 *
 * @return the current thread's value of this thread-local
 */
public T get() {
    Thread t = Thread.currentThread();
    ThreadLocalMap map = getMap(t);
    if (map != null) {
        //获取本地变量值,怎么获取的,见下文
        ThreadLocalMap.Entry e = map.getEntry(this);
        if (e != null) {
            @SuppressWarnings("unchecked")
            T result = (T)e.value;
            return result;
        }
    }
    return setInitialValue();
}
```

ThreadLocalMap 是ThreadLocal的一个静态内部类,在每个线程中都有一个ThreadLocalMap对象,用于存储线程本地变量
```
/* ThreadLocal values pertaining to this thread. This map is maintained
 * by the ThreadLocal class. */
ThreadLocal.ThreadLocalMap threadLocals = null;
```

线程获取本地变量是一个什么过程?
> ThreadLocalMap 获取ThreadLocal对应的本地变量

```
/**
 * Get the entry associated with key.  This method
 * itself handles only the fast path: a direct hit of existing
 * key. It otherwise relays to getEntryAfterMiss.  This is
 * designed to maximize performance for direct hits, in part
 * by making this method readily inlinable.
 *
 * @param  key the thread local object
 * @return the entry associated with key, or null if no such
 */
private Entry getEntry(ThreadLocal<?> key) {
    //获取ThreadLocal的哈希code 并和表的长度-1做与运算
    int i = key.threadLocalHashCode & (table.length - 1);
    Entry e = table[i];
    if (e != null && e.get() == key)
        return e;
    else
        //如果没找到继续(采用的是"开放地址"来解决key冲突)
        return getEntryAfterMiss(key, i, e);
}
```

## 0x61c88647魔数

>ThreadLocal关于产生hashcode的相关代码

```
//final变量,区分不同的ThreadLocal实例
private final int threadLocalHashCode = nextHashCode();

private static AtomicInteger nextHashCode =
    new AtomicInteger();

private static final int HASH_INCREMENT = 0x61c88647;
//获取线程的hashcode,每次调用都加上一个0x61c88647(ThreadLocalMap必须是2的整数次幂),
//保证了hashcode的冲突降到了很低,哈希code基本上是均匀分布的
private static int nextHashCode() {
    return nextHashCode.getAndAdd(HASH_INCREMENT);
}
```

**为什么魔数这么神奇**
让我们在本地验证一下,编辑文件名为 `magic_number.sh`的文件,输入以下shell脚本:

```
#!/bin/bash

MAGIC_CODE=0x61c88647
TABLE_SIZE=$1
hashcode=0
i=0
while [ "$i" -lt "$TABLE_SIZE" ]
do
    hashcode=$(( $hashcode +$MAGIC_CODE ))
    index=$(( ($hashcode + $MAGIC_CODE) & ($TABLE_SIZE - 1) ))
    echo -n "$index "
    i=$(( $i + 1 ))
done
```
运行一下

```
sh magic_number.sh 32
#结果为:
14 21 28 3 10 17 24 31 6 13 20 27 2 9 16 23 30 5 12 19 26 1 8 15 22 29 4 11 18 25 0 7
```

## ThreadLocalMap

线程中保存本地变量的结构,值得注意的是,map中每个本地变量的实体

```
static class ThreadLocalMap {

    //存储本地变量的实体,初始Entry[]数组的大小为16超过数组容量的2/3进行扩容
    static class Entry extends WeakReference<ThreadLocal<?>> {
        /** The value associated with this ThreadLocal. */
        Object value;

        Entry(ThreadLocal<?> k, Object v) {
            //对ThreadLocal变量的弱引用
            super(k);
            value = v;
        }
    }
```

**关于Entry的key的弱引用**

key是对ThreadLocal的一个弱引用,所以在ThreadLocal没有强引用指向它时,在系统执行GC时是不会组织对ThreadLocal的回收,此时key为null,无法对value进行访问了

![弱引用](www.codingted.com:9090/java/img/threadLocal_weekref.jpg)

### set

```
/**
 * Set the value associated with key.
 *
 * @param key the thread local object
 * @param value the value to be set
 */
private void set(ThreadLocal<?> key, Object value) {

    // We don't use a fast path as with get() because it is at
    // least as common to use set() to create new entries as
    // it is to replace existing ones, in which case, a fast
    // path would fail more often than not.
    
    Entry[] tab = table;
    int len = tab.length;
    int i = key.threadLocalHashCode & (len-1);

    //线性探测(有魔数的存在什么情况下会出现探测的情况?还没搞清楚)
    for (Entry e = tab[i];
         e != null;
         e = tab[i = nextIndex(i, len)]) {
        ThreadLocal<?> k = e.get();

        if (k == key) {
            e.value = value;
            return;
        }

        if (k == null) {
            replaceStaleEntry(key, value, i);
            return;
        }
    }

    //新添加对当前ThreadLocal的键值对,并判断是否需要扩容(并进行rehash操作)
    //如果容量超过当前容量的2/3则將容量扩容为现在的2倍
    tab[i] = new Entry(key, value);
    int sz = ++size;
    if (!cleanSomeSlots(i, sz) && sz >= threshold)
        rehash();
}
```

