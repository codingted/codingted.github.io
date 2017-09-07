## 简单动态字符串

redis实现了一种名为简单动态字符串（simple dynamic string, SDS）的抽象数据类型，并將SDS作为Redis的默认字符串.
SDS除了作为字符串值外，还被用作缓冲区(buffer):AOF模块中的AOF缓冲区，一级客户端状态中的缓冲区，都是由SDS实现的.

```
*./src/sds.h*
struct sdshdr {
    unsigned int len;
    unsigned int free;
    char buf[];
};

```
**数据结构**

|---------------------|     
|'a'|'b'|'c'|'\0'|''|''|''|      
|---------------------|      

此时 *lenth=3* *free=3*

### SDS实现和C字符串的区别

* 为了保证效率，SDS记录了字符串的长度 len,所以SDS获取长度为O(1),但是C取字符串长度是O(n),所以STRLEN命令的时间复杂度为O(1)
* 杜绝了缓冲区溢出
* 减少了内存的重新分配
    * 空间预分配
    * 惰性空间释放
* Redis不使用'\0'作为结束，而是使用len值来决定，所以Redis可以保存二进制格式

# 链表

链表数据结构及常用函数(adlist.c/adlist.h)

# 字典

又称符号表(symbol table)

## 字典的数据结构

dic.h

## hash算法

MurmurHash2 算法：即使是输入相近的值依然有很好的随机性，参考地址：http://code.google.com/p/smhasher/


## 解决键冲突

使用链地址法(separate chaining), 为了速度考虑，將新的节点排在链表的头部

## rehash

步骤：
1. 为字典h[1]分配空间
    * 如果执行的是扩展则ht[1]=ht[0].used*2
    * 如果执行的是收缩ht[1]=ht[0]
2. 將所有的键值对rehash到ht[1]
3. ht[0]迁移到ht[1]之后释放ht[0]將ht[1]设置成ht[0],为ht[1]创建空白hash表

rehash出现的条件:

* 服务器目前没有执行BGSAVE命令或者BGREWRITEAOF命令，并且hash表的负载因子大于等于1
* 服务器正在执行BGSAVE命令或者BGREWRITEAOF命令，并且hash表的负载因大于等于5

```
# 负载因子计算公式
load_factor = ht[0].used / ht[0].size
```
另一方面负载因子小于0.1时开始进行收缩操作

## 渐进式rehash

渐进式rehash步骤:

* 为ht[1]分配空间
* 將索引计数器变量rehashindex值设置为0，标识rehash工作正式开始
* 在rehash工作期间，对字典的执行的增加/删除/查找/或更新的操作会顺带將ht[0]hash表中在rehashidx索引上的所有键值对rehash到ht[1],当rehash工作完成后rehashidx属性值加一
* 最终所有键值对rehash到ht[1],这是將rehashidx设置为-1，rehash工作完成

# 跳跃表

跳跃表(skiplist)是一种有序数据结构，在Redis中使用的地方：

## 数据结构

```
typedef struct redisObject {
    //类型
    unsigned type:4;
    //编码
    unsigned encoding:4;
    unsigned lru:REDIS_LRU_BITS; /* lru time (relative to server.lruclock) */
    int refcount;
    //指向底层数据结构的指针
    void *ptr;
} robj;


```

* 有序集合键
* 集群节点中用作内部数据结构

## 数据结构

redis.h->zskiplistNode / zskiplist

# 整数集合

## 数据结构

intset.h

## 数据提升

# 压缩列表

压缩列表(ziplist),是列表键和hash键的底层实现之一.

# 对象

简单动态字符串(SDS)/双端链表/字典/压缩列表/整数集合..

现在的对象：

* 字符串
* 列表
* 哈希
* 集合
* 有序集合

根据这些对象可以在执行命令之前通过判断对象类型来决定是否能够执行给定的命令.

## 类型

类型常量        | 对象的名称
----------------|------------
REDIS_STRING    |字符串 
REDIS_LIST      |列表
REDIS_HASH      |哈希
REDIS_SET       |集合
REDIS_ZSET      |有序集合

> value 大小不能大于512M(Redis 4.0)
