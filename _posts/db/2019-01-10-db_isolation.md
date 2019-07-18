---
title: 数据库隔离级别
category: db
tags:  db isolation
---

## 数据库隔离级别

事务之间对于数据的可见性

隔离级别    |脏读（Dirty Read） |不可重复读（NonRepeatable Read）   |幻读（Phantom Read）
|-----------------------------|------|-------|----
未提交读（Read uncommitted，RU）|可能   |可能   |可能
已提交读（Read committed，RC）  |不可能 |可能   |可能
可重复读（Repeatable read，RR） |不可能 |不可能 |可能
可串行化（SERIALIZABLE）        |不可能 |不可能 |不可能

<!-- more -->

### 未提交读（Read uncommitted，RU）

是最低的隔离级别。允许“脏读”（dirty reads），事务可以看到其他事务“尚未提交”的修改。

### 已提交读（Read committed，RC）

基于锁机制并发控制的DBMS需要对选定对象的写锁一直保持到事务结束，但是读锁在SELECT操作完成后马上释放（因此“不可重复读”现象可能会发生，见下面描述）。和可重复读（Repeatable read，RR）隔离级别一样，也不要求“范围锁”。

### 可重复读（Repeatable read，RR）

基于锁机制并发控制的DBMS需要对选定对象的读锁（read locks）和写锁（write locks）一直保持到事务结束，但不要求“范围锁”，因此可能会发生“幻影读”。

### 可串行化（SERIALIZABLE）

最高的隔离级别。

在基于锁机制并发控制的DBMS实现可串行化，要求在选定对象上的读锁和写锁保持直到事务结束后才能释放。在SELECT 的查询中使用一个“WHERE”子句来描述一个范围时应该获得一个*范围锁（range-locks）*。这种机制可以避免“幻读”（phantom reads）现象。

[MySQL Gap Lock问题](https://www.cnblogs.com/diegodu/p/9239200.html)
[事务隔离](https://en.wikipedia.org/wiki/Isolation_(database_systems))
[innodb locking transaction model](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking-transaction-model.html)
