---
layout: post
title:  Mysql存储过程打印调试信息
categories: db mysql
tags:  mysql
---

* content
{:toc}

```SQL

-- 输出调试信息
DELIMITER $$

DROP PROCEDURE IF EXISTS debug_msg $$
CREATE PROCEDURE debug_msg(enabled INTEGER, msg VARCHAR(255))
BEGIN
  IF enabled THEN
    select concat("** ", msg) AS '** DEBUG:';
END IF;

   END $$

DELIMITER ;

```
