---
title: InnoDB 锁分类
category: db
tags:  MySQL lock
---

## 共享/排它锁（Shared and Exclusive Locks）

InnoDB实现了标准的行级锁：shared(S) lock 和 exclucive(X) lock

1. 事务获得某一行的共享S锁才可以读取这一行，允许多个事务持有某一行的共享S锁（读读可以并行）
2. 事务获取某一行的排它X锁可以对这一行尽心`修改`或`删除`，不允许多个事务同时持有某一行的排它X锁（读写，写写不可以并行）

> 注意： 如果事务T1已经获取了某一行的共享S锁，此时如果T2想要获取改行的排它X锁是不能立即获取的

## 意向锁(Intention Locks)

意向锁是一种`表锁`，支持多粒度锁定（multiple granularity locking），允许行锁和表锁共存。

1. 意向共享锁(intention shared lock, IS)，它预示着，事务有意向对表中的某些行加共享S锁
2. 意向排它锁(intention exclusive lock, IX)，它预示着，事务有意向对表中的某些行加排它X锁

> 举个例子：  
>
> SELECT ... FOR SHARE 设置的是意向共享锁（IS锁）  
> SELECT ... FOR UPDATE 设置的是意向排它锁（IX锁）

意向锁的协议如下：

1. 一个事务在获取共享S锁之前，需要获取意向共享锁（IS锁）或者更强的锁；
2. 一个事务在获取排它X锁之前，需要获取意向排它锁（IX锁）。

| | X         |IX       |S          |IS
--|-----------|---------|-----------|--
X | Conflict  |Conflict | Conflict  |Conflict
IX| Conflict  |Compatible|  Conflict|Compatible
S | Conflict  |Conflict |Compatible |Compatible
IS| Conflict  |Compatible|  Compatible|Compatible

## 记录锁(Record Locks)

锁住`索引记录`。

例如： `select * from t where id = 10 for update` 对于id=10的记录的修改，插入，删除操作都会失败。（而普通的`select * from t where id = 10` 在RR隔离级别下只是`快照读`(SnapShot Read)，并不加锁）

## 间隙锁(Gap Locks)

间隙锁是在索引的间隙加的锁，主要目的是为了防止其他事务在间隔中插入数据，以导致`不可重复读`。

如果事务隔离级别降低为读提交（Read Commited, RC）则间隙锁会失效。

例如，`SELECT c1 FROM t WHERE c1 BETWEEN 10 and 20 FOR UPDATE;`将阻止其他事务将值15插入到列t.c1中，无论列中是否已存在任何此类值，因为该范围内所有现有值之间的间隔都被锁定。但是可以进行范围内的值的UPDATE操作。

## 临键锁(Next-key Locks)

临键锁，是记录锁与间隙锁的组合，它的封锁范围，既包含索引记录，又包含索引区间。

临键锁的主要目的，是为了避免幻读(Phantom Read)

## 插入意向锁(Insert Intention Locks)

多个事务，在同一个索引，同一个范围区间插入记录时，如果插入的位置不冲突，不会阻塞彼此。

## 自增锁(Auto-inc Locks)

自增锁是一种特殊的表级别锁（table-level lock），专门针对事务插入AUTO_INCREMENT类型的列。最简单的情况，如果一个事务正在往表中插入记录，所有其他事务的插入必须等待，以便第一个事务插入的行，是连续的主键值。

使用[innodb_autoinc_lock_mode](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_autoinc_lock_mode)可以配置自增锁的行为，它允许你选择如何在可预测的自动增量值序列和插入操作的最大并发之间进行权衡。

```SQL
-- 数据库状态
SHOW ENGINE INNODB STATUS;

-- 数据库事务锁的状态
USE INFORMATION_SCHEMA
SELECT * FROM INNODB_LOCK_WAITS;

-- 事务详情
SELECT * FROM INNODB_LOCKS  
WHERE LOCK_TRX_ID IN (SELECT BLOCKING_TRX_ID FROM INNODB_LOCK_WAITS);
OR
SELECT INNODB_LOCKS.*  
FROM INNODB_LOCKS
JOIN INNODB_LOCK_WAITS
  ON (INNODB_LOCKS.LOCK_TRX_ID = INNODB_LOCK_WAITS.BLOCKING_TRX_ID);

-- 具体表的锁情况
SELECT * FROM INNODB_LOCKS  
WHERE LOCK_TABLE = db_name.table_name;
A list of transactions waiting for locks: 

--事务状态
SELECT TRX_ID, TRX_REQUESTED_LOCK_ID, TRX_MYSQL_THREAD_ID, TRX_QUERY
FROM INNODB_TRX
WHERE TRX_STATE = 'LOCK WAIT';

[事务隔离级别]({{ site.blog_url }}/2019/01/10/db_isolation.html)  
[InnoDB并发插入，居然使用意向锁](https://mp.weixin.qq.com/s?__biz=MjM5ODYxMDA5OQ==&mid=2651961461&idx=1&sn=b73293c71d8718256e162be6240797ef&chksm=bd2d0da98a5a84bfe23f0327694dbda2f96677aa91fcfc1c8a5b96c8a6701bccf2995725899a&scene=21#wechat_redirect)  
[InnoDB，select为啥会阻塞insert](https://mp.weixin.qq.com/s?__biz=MjM5ODYxMDA5OQ==&mid=2651961471&idx=1&sn=da257b4f77ac464d5119b915b409ba9c&chksm=bd2d0da38a5a84b5fc1417667fe123f2fbd2d7610b89ace8e97e3b9f28b794ad147c1290ceea&scene=21#wechat_redirect)
[innnodb consistent read](https://dev.mysql.com/doc/refman/8.0/en/innodb-consistent-read.html)
