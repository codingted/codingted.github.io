---
title:  oracle常用查看表结构
categories: db oracle
tags: db oracle
comments: true
---

# 概要

oracle基本操作, 查看表的信息.

<!-- more -->

# 取表

```sql
select table_name from user_tables; //当前用户的表       

select table_name from all_tables; //所有用户的表   

select table_name from dba_tables; //包括系统表

select table_name from dba_tables where owner='用户名'
```

**user_tables：**
    table_name,tablespace_name,last_analyzed等

**dba_tables：**
    ower,table_name,tablespace_name,last_analyzed等

**all_tables：**
    ower,table_name,tablespace_name,last_analyzed等

  **all_objects：**
    ower,object_name,subobject_name,object_id,created,last_ddl_time,timestamp,status等

# 获取表字段：
```sql
select * from user_tab_columns where Table_Name='用户表';

select * from all_tab_columns where Table_Name='用户表';

select * from dba_tab_columns where Table_Name='用户表';
```
  **user_tab_columns：**
    table_name,column_name,data_type,data_length,data_precision,data_scale,nullable,column_id等

  **all_tab_columns ：**
    ower,table_name,column_name,data_type,data_length,data_precision,data_scale,nullable,column_id等

  **dba_tab_columns：**
    ower,table_name,column_name,data_type,data_length,data_precision,data_scale,nullable,column_id等

# 获取表注释：
```
select * from user_tab_comments
```
**user_tab_comments：**

table_name,table_type,comments  
--相应的还有dba_tab_comments，all_tab_comments，这两个比user_tab_comments多了ower列。

# 获取字段注释：
```
select * from user_col_comments
```

**user_col_comments：**
table_name,column_name,comments
