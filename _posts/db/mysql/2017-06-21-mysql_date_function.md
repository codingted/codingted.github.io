---
title:  mysql时间函数
categories: db mysql
tags: mysql 数据库函数
comments: true
---

# 概要

mysql常用的时间操作,mark一下

<!-- more -->

# MySQL 获得当前日期时间(date+time) 函数

### 获得当前日期+时间（date + time）

> select now();   
> select sysdate();

两者之间的区别：now() 在执行开始时值就得到了， sysdate() 在函数执行时动态得到值

> select now(), sleep(3), now();
>
> +---------------------+----------+---------------------+  
> | now() | sleep(3) | now() |  
> +---------------------+----------+---------------------+  
> | 2008-08-08 22:28:21 | 0 | 2008-08-08 22:28:21 |		 
> +---------------------+----------+---------------------+  


> select sysdate(), sleep(3), sysdate();
>
> +---------------------+----------+---------------------+  
> | sysdate() | sleep(3) | sysdate() |  
> +---------------------+----------+---------------------+  
> | 2008-08-08 22:28:41 | 0 | 2008-08-08 22:28:44 |		
> +---------------------+----------+---------------------+

### 获得当前日期（date）函数：curdate()

### 获得当前时间（time）函数：curtime()

### 获得当前 UTC 日期时间函数：utc_date(), utc_time(), utc_timestamp()

# MySQL 日期时间 Extract（选取） 函数

### 选取日期时间的各个部分：日期、时间、年、季度、月、日、小时、分钟、秒、微秒

> set @dt = '2008-09-10 07:15:30.123456';
>
> select date(@dt); -- 2008-09-10		
> select time(@dt); -- 07:15:30.123456		
> set @dt = '2008-09-10 07:15:30.123456';
> select year(@dt); -- 2008		
> select quarter(@dt); -- 3		
> select month(@dt); -- 9		
> select week(@dt); -- 36		
> select day(@dt); -- 10		
> select hour(@dt); -- 7		
> select minute(@dt); -- 15		
> select second(@dt); -- 30		
> select microsecond(@dt); -- 123456		

### MySQL Extract() 函数，可以上面实现类似的功能：

> set @dt = '2008-09-10 07:15:30.123456';

> select extract(year from @dt); -- 2008		
> select extract(quarter from @dt); -- 3		
> select extract(month from @dt); -- 9		
> select extract(week from @dt); -- 36		
> select extract(day from @dt); -- 10		
> select extract(hour from @dt); -- 7		
> select extract(minute from @dt); -- 15		
> select extract(second from @dt); -- 30		
> select extract(microsecond from @dt); -- 123456		
> 		
> select extract(year_month from @dt); -- 200809		
> select extract(day_hour from @dt); -- 1007		
> select extract(day_minute from @dt); -- 100715		
> select extract(day_second from @dt); -- 10071530		
> select extract(day_microsecond from @dt); -- 10071530123456		
> select extract(hour_minute from @dt); -- 715		
> select extract(hour_second from @dt); -- 71530		
> select extract(hour_microsecond from @dt); -- 71530123456		
> select extract(minute_second from @dt); -- 1530		
> select extract(minute_microsecond from @dt); -- 1530123456		
> select extract(second_microsecond from @dt); -- 30123456		

### MySQL dayof... 函数：dayofweek(), dayofmonth(), dayofyear()

> dayofweek() （1 = Sunday, 2 = Monday, ..., 7 = Saturday）

### MySQL week... 函数：week(), weekofyear(), dayofweek(), weekday(), yearweek()

 weekday() 函数和 dayofweek() 类似，都是返回“某天”在一周中的位置。不同点在于参考的标准， weekday：(0 = Monday, 1 = Tuesday, ..., 6 = Sunday)； dayofweek：（1 = Sunday, 2 = Monday, ..., 7 = Saturday）

### MySQL 返回星期和月份名称函数：dayname(), monthname()

> select dayname(@dt); -- Friday
> select monthname(@dt); -- August

### MySQL last_day() 函数：返回月份中的最后一天。

> select last_day('2008-02-01'); -- 2008-02-29 	
> select last_day('2008-08-08'); -- 2008-08-31

# MySQL 日期时间计算函数

### MySQL 为日期增加一个时间间隔：date_add(), date_sub()

> set @dt = now();
>
> select date_add(@dt, interval 1 day); -- add 1 day 	
> select date_add(@dt, interval 1 hour); -- add 1 hour 	
> select date_add(@dt, interval 1 minute); -- ... 	
> select date_add(@dt, interval 1 second);
> select date_add(@dt, interval 1 microsecond);
> select date_add(@dt, interval 1 week);
> select date_add(@dt, interval 1 month);
> select date_add(@dt, interval 1 quarter);
> select date_add(@dt, interval 1 year);
> select date_add(@dt, interval '01:15:30' hour_second);
> select date_add(@dt, interval '1 01:15:30' day_second);


# MySQL 日期转换函数、时间转换函数

### MySQL （时间、秒）转换函数：time_to_sec(time), sec_to_time(seconds)

> select time_to_sec('01:00:05'); -- 3605
> select sec_to_time(3605); -- '01:00:05'

### MySQL （日期、天数）转换函数：to_days(date), from_days(days)

> select to_days('0000-00-00'); -- 0
> select to_days('2008-08-08'); -- 733627
> 	
> select from_days(0); -- '0000-00-00'
> select from_days(733627); -- '2008-08-08'

### MySQL Str to Date （字符串转换为日期）函数：str_to_date(str, format)

> select str_to_date('08/09/2008', '%m/%d/%Y'); -- 2008-08-09
> select str_to_date('08/09/08' , '%m/%d/%y'); -- 2008-08-09
> select str_to_date('08.09.2008', '%m.%d.%Y'); -- 2008-08-09
> select str_to_date('08:09:30', '%h:%i:%s'); -- 08:09:30
> select str_to_date('08.09.2008 08:09:30', '%m.%d.%Y %h:%i:%s'); -- 2008-08-09 08:09:30

### MySQL Date/Time to Str（日期/时间转换为字符串）函数：date_format(date,format), time_format(time,format)

> mysql> select date_format('2008-08-08 22:23:00', '%W %M %Y');
