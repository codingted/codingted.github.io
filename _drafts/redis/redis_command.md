# List 

* LPUSH
* LPOP


```
# LPUSH
# LPOP
# BRPOP
//等待task 如果5秒中没有获得就返回
> brpop tasks 5

# HMSET 

> hmset user:1000 name liang age 30

# HGET 
> hget user:1000 name

# HINCRBY
> hincrby user:1000 age 10
```

# SET 

```
# SADD
> sadd myset 1 2 3
//顺序不定
> smembers myset
> sismember myset 1
# SPOP
//随机
> spop myset 
//set number
> scard myset
```

# Sorted SET

```
# ZADD
> zadd hackers 1912 "Alan Turing"
# ZRANGE
> zrange hackers 0 -1

# ZREVRANGE
> zrevrange hackers 0 -1
> zrevrange hackers 0 -1 withscores
>
```

# Bitmaps

```
> setbit key 10 1
> getbit key 10
> getbit key 11
```


# 

* SET、GET、APPEND、STRLEN等命令只能对字符串键执行
* HDEL、HSET、HGET、HLEN等命令只能对哈希键执行；
* RPUSH、LPOP、LINSERT、LLEN等命令只能对列表键执行；
* SADD、SPOP、SINTER、SCARD等命令只能对集合键执行；
* ZADD、ZCARD、ZRANK、ZSCORE等命令只能对有序集合键执行；
