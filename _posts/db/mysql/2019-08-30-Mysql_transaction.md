---
title: Mysql事务
category: db
tags:  MySQL
---

极客时间"Mysql实战45讲"讲的真是很精彩,看到事务的文章更是感到茅塞顿开,下边写下整理,以备后面思考!

## 隔离性和隔离级别

事务绕不开的ACID:
* Atomicity(原子性)
* Consistency(一致性)
* Isolation(隔离性)
* Durability(持久性)

当数据库上有多个事务同时执行的时候，就可能出现脏读（dirty read）、不可重复读（non-repeatable read）、幻读（phantom read）的问题，为了解决这些问题，就有了“隔离级别”的概念。

事务标准的隔离级别:
* 读未提交(read uncommited):可以读到其它事务未提交的数据
* 读提交(read committed):事务提交的数据可以读到
* 可重复读(repeatable read):事务执行中读到的数据和启动事务时的数据一致
* 串行化(serializable):对同一行数据采用"读锁"和"写锁"保证在读写冲突的时候后访问的事务必须要等前一个事务执行完成,才能继续执行.

当然隔离级别越高,效率越差!

> 注意:     
> 不同数据库的行为是不同的.Oracle数据库的默认隔离级别是"读提交",这一点在Oracle迁移到Mysql的应用需要考虑是否需要设置MySQL的隔离级别设置为"读提交".  
> 设置启动参数`transaction-isolation`为**READ-COMMITTED**  
> `mysql> show variable like 'transactin_isolation'`

<!-- more -->


## 事务隔离级别的实现

更新操作的同时数据库会记录一条回滚操作.记录的最新值可以通过回滚操作得到前面的状态的值.

下图是一个值从 1被顺序改成 2,3,4时,在回滚日志中的记录示意图

![回滚日志示意图]({{ site.img_server }}/db/mysql_undo_log.png)

不同时刻启动的事务会有不同的read-view.同一条记录在系统中可以存在多个版本,即使数据库的多版本并发控制(MVCC).

> 回滚日志什么时间删除呢?   
> 答案: 不需要的时候.   
>
> 如何判断什么时间是不需要的时候?   
> 答案: 系统没有比这个回滚日志更早的read-view的时候.

基于上面的回滚日志的删除时机, 建议尽量不使用长事务.

## 事务的启动方式

1. 显示启动事务.begin 或 start transaction,配套使用commit,rollback可以结束事务.
2. `set autocommit=0`,这个设置会将自动提交关闭,这意味着即使执行一个select语句,这个事务并没有自动提交,这个事务会持续存在,知道主动执行 commit或rollback语句或者断开连接.

> Tips:
>
> 建议总是使用 `set autocommit=1` , 通过显式语句的方式来启动事务.  
> 但是有的开发同学会纠结“多一次交互”的问题。对于一个需要频繁使用事务的业务，第二种方式每个事务在开始时都不需要主动执行一次 “begin”，减少了语句的交互次数。如果你也有这个顾虑，建议你使用 commit work and chain 语法。   
> 可以在 `information_schema` 库的 `innodb_trx` 这个表中查询长事务，比如下面这个语句，用于查找持续时间超过 60s 的事务。  

```sql
select * from information_schema.innodb_trx where TIME_TO_SEC(timediff(now(),trx_started))>60
```

## 事务执行的例子

事务A   |事务B  |事务C
--------|-------|--------
start transaction with consistent snapshot; | |
        |start transaction with consistent snapshot;|
        |       |update t set k=k+1 where id = 1;
        |update t set k=k+1 where id = 1;|  
        |select k from t where id = 1;|
select k from t where id = 1;||
commit; |       |
        |commit;|

** 例子中没有特别说明都是autocommit=1 **

## 事务的启动时机
begin/start transaction 并不是事务的起点,在之习惯到他们之后的地一个操作的InnoDB表的语句,事务才真正的启动.想要马上启动事务,可以使用`start transaction with consistent snapshot`

> 第一种启动方式,一致性试图实在执行地一个快照读语句是创建的;    
> 第二种启动方式,一致性试图是在执行`start transaction with consistent snapshot`时创建的.

所以上面的例子事务A和事务B实在创建就开始了,事务C本身执行update语句就是一个事务,语句完成自动提交.

> 例子查询的执行结果:   
> 事务B查到的k的值是3,事务A查到的k的值是1

(如果和自己分析的不一致,请带着问题往下看)

在 MySQL 里，有两个“视图”的概念:

* 一个是 view。它是一个用查询语句定义的虚拟表，在调用的时候执行查询语句并生成结果。创建视图的语法是 create view … ，而它的查询方法与表一样。
* 另一个是 InnoDB 在实现 MVCC 时用到的一致性读视图，即 consistent read view，用于支持 RC（Read Committed，读提交）和 RR（Repeatable Read，可重复读）隔离级别的实现。

## "快照"在MVCC是如何工作的

> 每一事务在启动时都会生成一个唯一的事务id(transaction id),在数据库的事务系统中是按顺序严格递增的

这里的"快照"并不是完全拷贝的整库,而是在每个事务更新数据会生成一个新的数据版本,并且把transaction id 赋值给这个数据版本的事务id,记为row trx_id.同时保留就的数据版本记录.
也就是说,数据表中的一行记录,其实是有多个版本,每个版本有自己的row trx_id.

![数据的多个版本]({{ site.img_server }}/db/row_trx_id.png)

图中的虚线箭头就是undo log(回滚日志),而V1,V2,V3并不是物理存在的而通过当前版本和undo log 计算出来的.

一个事务在启动时就相当于声明了"以我启动的时刻为准，如果一个数据版本是在我启动之前生成的，就认；如果是我启动以后才生成的，我就不认，我必须要找到它的上一个版本"

当然，如果“上一个版本”也不可见，那就得继续往前找。还有，如果是这个事务自己更新的数据，它自己还是要认的。

假设事务A,事务B,事务C的id分别为100,101,102, 并且在这之前最后一个变更该数据版本的事务id为99,并且执行完成之后的值为1.

根据事务的隔离规则我们可能得出的结论是:事务A的查询结果是1, 事务B的查询结果是2, (但是细想一下这不是丢失了事务C的更新结果?不符合逻辑呀)
整个的执行过程:
1. 事务C执行过后k的当前版本的值是2
2. 事务B执行更新操作需要在当前版本的基础上进行更新,重点说明:确实,如果在update之前查询k的值得到的应该一直是1,但是更新数据都是先读后写,而这个读只能读取当前的值,成为"当前读"(current read),因此实在k=2的基础之上进行更新,得到k的值为3
3. 事务B执行查询操作,得到之前在本事务中更新的k的值3
4. 事务A因为一直存在于自己的一致性视图中所以查询到的值是1

## 例子执行的变体

事务A   |事务B  |事务C
--------|-------|--------
start transaction with consistent snapshot; | |
        |start transaction with consistent snapshot;|
        |       |start transaction with consistent snapshot;
        |       |update t set k=k+1 where id = 1;
        |update t set k=k+1 where id = 1;|  
        |select k from t where id = 1;|
        |       |commit;
select k from t where id = 1;||
commit; |       |
        |commit;|

提示:需要考虑事务在该记录上添加的排它锁(两阶段锁协议).

## 总结

现在回答,事务的可重复读的能力是怎么实现的？

> 可重复读的核心就是一致性读（consistent read）；而事务更新数据的时候，只能用当前读。如果当前的记录的行锁被其他事务占用的话，就需要进入锁等待。

读提交的可重复读的主要区别:

* 在可重复读隔离级别下，只需要在事务开始的时候创建一致性视图，之后事务里的其他查询都共用这个一致性视图；
* 在读提交隔离级别下，每一个语句执行前都会重新算出一个新的视图。
