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
# SREM
// 删除
//SREM key-name item [items ...]

# SISMEMBER 
// SISMEMBER key-name item

# SCARD
// 集合中元素的数量
//SCARD key-name
```
**common**

命令        | eg                            | 说明
------------|-------------------------------|------
SADD        |SADD key-name item [items...]  | 
SREM        |SREM key-name item             |
SISMEMBER   |SISMEMBER key-name item        |
SCARD       |SCARD key-name                 |
SMEMBERS    |SMEMBERS key-name              |
SRANDMEMEBER|SRANDMEMBER key-name           |
SPOP        |SPOP key-name                  | return and remove one item random
SMOVE       |SMOVE key-name dest-key item   | move item from 'key-name' to 'dest-key' and return 'true' if exist

**collection operate**

命令        | eg                            | 说明
------------|-------------------------------|------
SDIFF       |SDIFF key-name key-name2       |
SDIFFSTORE  |SDIFFSTORE dest-key key-name[...]|
SINTER      |SINTER key1 key2               |
SINTERSTORE |SINTERSTORE desk-key key1 key2 | 
SUNION      |SUNION key1 key2               |
SUNIONSTORE |SUNIONSTORE dest-key key1 key2 | 


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


# Hash

命令        | eg                            | 说明
------------|-------------------------------|------
HMGET       |HMGET key-name key [key...]    | 
HMSET       |HMSET key-name key value key value|
HDEL        |HDEL key-name key [key...]     |
HLEN        |HLEN key-name                  |

命令        | eg                            | 说明
------------|-------------------------------|------
HEXIST      |HEXIST key-name key            |
HKEYS       |HKEYS key-name                 |
HVALS       |HVALS key-name                 |
HGETALL     |HGETALL key-name               |
HINCRBY     |HINCRBY key-name key incr      |
HINCRBYFLOAT|HINCRBYFLOAT key-name key incr |

# Sorted Set 

命令        | eg                            | 说明
------------|-------------------------------|------
ZADD        |ZADD key-name score member[score member]|
ZREM        |ZREM key-name member           |
ZCARD       |ZCARD key-name                 |
ZINCRBY     |ZINCRBY key-name incr member   |
ZCOUNT      |ZCOUNT key-name min max        |
ZRANK       |ZRANK key-name member          |index in set
ZSCORE      |ZSCORE key-name member         |
ZRANGE      |ZRANGE key-name start stop     |list index in set 
