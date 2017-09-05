## String 

不可变对象，内部声明的char数组：

```
private final char value[];
```

# 可变

StringBuffer和StringBuilder都提供了初始化对象设置capacity（初始容量）的构造函数，防止了在动态改变对象内数组的过程中频繁的进行底层数组的拷贝；
空构造函数初始化了一个长度为16的char数组，带字符串的构造函数构造了一个该字符串长度+16的char数组

StringBuilder的toString()方法实现

```
@Override
public String toString() {
    // Create a copy, don't share the array
    // string 的构造函数中是对当前value数组的一个拷贝
    return new String(value, 0, count);
}
```

StringBuffer的toString()方法的实现

```
@Override
public synchronized String toString() {
    if (toStringCache == null) {
        //存储当前value数组的一个拷贝
        toStringCache = Arrays.copyOfRange(value, 0, count);
    }
    //使用toStringCache构造新的String对象
    return new String(toStringCache, true);
}
```

为什么不使用相同的方法？（还没弄明白，待续）
