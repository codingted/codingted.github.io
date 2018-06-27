---
title:  "mysql常用操作"
categories: db mysql
tags: db mysql
comments: true
---

## 用户管理

```sql
-- 新建用户
CREATE USER name IDENTIFIED BY 'password';

-- 更改密码
SET PASSWORD FOR name=PASSWORD('password');

-- 查看name用户权限
SHOW GRANTS FOR name;

-- 给用户user的db_name的增,改,查权限
GRANT SELECT, INSERT, UPDATE ON `db_naem`.* TO 'user'@'127.0.0.1';

-- 收回更新权限
REVOKE UPDATE ON db_name.* TO user;
```

<!-- more -->


## DDL操作

数据定义语言（Data Definition Lanuage, DDL）定义了数据库模式，包括CREATE、ALTER、DROP、TRUNCATE、COMMENT与RENAME语句。

```sql
-- CRATE
CREATE TABLE mgr(
  id INT ,
  name  VARCHAR(20),
  age INT
 );

-- ALTER

-- 修改列类型与列名
alter table mgr modify name varchar(32);
alter table mgr change name real_name varchar(64);

-- 追加列
alter table mgr add gender bit(3) NOT NULL COMMENT '性别' after id;

-- 修改列之间的顺序：
alter table mgr modify gender bit(3) after name;

-- 修改primary key：
alter table mgr drop primary key, add primary key (`id`,`name`);

-- 表重命名
RENAME TABLE name_old TO name_new;
ALTER TABLE name_old RENAME name_new;

-- DROP
drop table mgr;

-- TRUNCAT
truncat mgr;

```
## DML操作

数据定义语言（Data manipulation language, DML）主要用于表达数据库的查询与更新，主要包括增删改查（INSERT，UPDATE，DELETE，SELECT）。

## 数据库状态查询

```sql
-- 查看数据库中可用的表
show tables;

-- 查看表结构
desc mgr;
show columns in mgr;

-- 查看表的状态
SHOW TABLE STATUS;
-- 
```

## 技巧

```sql
-- 快速复制
create table mgr2 select * from mgr;
-- 复制部分
create table mgr2 select id,name,age from mgr;

-- 创建临时表
CREATE TEMPORARY TABLE tmp_mgr;
```

