---
title:  "Kafka应用应该知道的"
categories: java
tags: kafka
comments: true
---

## 概念

名称        | 解释
------------|-------
Broker      | 消息中间件处理节点，一个Kafka节点是一个broker，一个或者多个Broker可以组成一个Kafka集群
Topic       | Kafka根据topic对消息进行归类，发布到Kafka的消息都需要指定topic
Producer    | 消息生产者，向Broker中发送消息的客户端
Consumer    | 消息消费者，从Broker中读取消息的客户端
ConsumerGroup| 每个Consumer属于一个特定的 Consumer Group,一条消息可以发送到不同的Consumer Group，但是一个ConsumerGroup中只能有一个Consumer能够消费该消息
Partition   | 物理概念，一个topic可以分为多个partition，每个partition内部都是有序的（为了提高IO速度）


## Topic&Partition

topic为一类消息，可以被分为多个partition，在物理侧面每个partition为一个append log.
每条消息在文件中的位置成为偏移量(offset),offset为一个long型的数字,它唯一标记一条消息.每条消息被append到partition中(顺序写入磁盘,因此效率非常高,经验证顺序写入磁盘比随机写入内存效率还要高,这是kafka高吞吐率的一个保证).

> \# partition 的设置参数在$KAFKA_HOME/config/server.properties     
> num.partition=3

![消息写入]({{ site.img_server }}/java/write_to_partition.png)

发送一条消息时,可以指定消息的key,producer会根据这个key和partition机制来判断这个消息发送给哪个partition,partition机制可以通过指定**producer**的*partition.class*这一参数来指定,该class必须实现kafka.producer.Partition接口.

<!-- more -->

## 高可靠性存储

kafka的高可靠性源于其健壮的副本(replication)策略.

> \# partition级别的复制,replication数量可以在$KAFKA_HOME/config/server.properties中配置    
> default.replication.refactor

### Kafka文件存储机制

> Kafka中消息是以topic进行分类的，生产者通过topic向Kafka broker发送消息，消费者通过topic读取数据。然而topic在物理层面又能以partition为分组，一个topic可以分成若干个partition.

**topic及partition的存储方式**

> log.dirs=/tmp/kafka-logs(在$KAFKA_HOME/config/server.properties中配置)  
> topic: TTT  
> partition数量为:4($KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper localhost:2181 --partition 4 --topic TTT --replication-factor 4)

那么现在生成4个目录

```shell
drwxr-xr-x  2 zl   zl    4096 11月 21 16:24 TTT-0/
drwxr-xr-x  2 zl   zl    4096 11月 21 16:24 TTT-1/
drwxr-xr-x  2 zl   zl    4096 11月 21 16:24 TTT-2/
drwxr-xr-x  2 zl   zl    4096 11月 21 16:24 TTT-3/
```
*在Kafka文件存储中同一个topic下有多个不同的partition,每个partition一个目录,partition的规则为:topic名称+有序序号,第一个序号从0开始,最大的序号为partition数量减1*


![log]({{ site.img_server }}/java/setment_index_log.png)

为了防止partition无限制的扩大,每个partition中还会生成多个段(segment),segment文件由两部分组成，分别为“.index”文件和“.log”文件，分别表示为segment索引文件和数据文件。这两个文件的命令规则为：partition全局的第一个segment从0开始，后续每个segment文件名为上一个segment文件最后一条消息的offset值，数值大小为64位，20位数字字符长度，没有数字用0填充，如下：

> 00000000000000000000.index    
> 00000000000000000000.log    
> 00000000000000170410.index    
> 00000000000000170410.log    
> 00000000000000239430.index    
> 00000000000000239430.log    

> \# segment的文件生命周期参数  
> log.segment.bytes     
> log.roll.{ms,hours}   
> 等参数    

### 复制原理和同步方式

> HW(HighWatermark):Consumer能够看到此partition的位置   
> LEO(LogEndOffset):每个partition的log最后一条Message的位置.    

Kafka通过多副本机制实现故障转移,当Kafka集群中一个broker失效时仍然保证服务可用.在Kafka中发生复制时确保partition的日志能有序的写到其它节点(副本节点)上,N个replicas,其中一个为**leader**,其它的为**follower**,leader 处理partition的所欲的读写请求,同事follow二会被动定期地去复制leader上的数据.

![]({{ site.img_server }}/java/partion_points.png)

**ISR**

副本同步队列(In-Sync Replicas).

副本同步队列由leader负责维护和跟踪所有的follower滞后的状态.

> 当producer发送一条消息到Brokder后,leader写入消息并复制到所有的follower.消息复制延迟受最慢的follower限制,如果follower"落后"太多或者失败,leader将会把它从ISR中删除.
> *延迟相关参数*
> offsets.topic.replication.factor(副本数量)
> *以下任何一个超过阈值都会將follower从ISR中剔除,存入OSR(Outof-Sync Replicas)列表,新加入的follower也会先存放到OSR中*
> replica.lag.time.max.ms(延迟时间)
> replica.lag.max.messages(延迟条数 0.10.x版本后移除)

**HW**

(HighWatermark)俗称高水位,每一个partition对应的ISR中最小的LEO作为HW,consumer最懂只能消费到HW所在的位置.另外每个replica都有HW,leader和follower各自负责更新自己的HW状态.

对于leader新写入的消息,consumer不能立刻消费,leader会等待消息被所有的ISR中的replicas同步后更新HW,此时消费才能被消费.这样保证了leader中的消息在所有的broker失效消息仍然能够从新选举的leader中获取,对于来自内部的broker读取请求,没有HW的限制.

kafka的ISR管理最终会反馈到Zookeeper节点上.

???

具体位置为：/brokers/topics/[topic]/partitions/[partition]/state。目前有两个地方会对这个Zookeeper的节点进行维护：

* Controller来维护：Kafka集群中的其中一个Broker会被选举为Controller，主要负责Partition管理和副本状态管理，也会执行类似于重分配partition之类的管理任务。在符合某些特定条件下，Controller下的LeaderSelector会选举新的leader，ISR和新的leader_epoch及controller_epoch写入Zookeeper的相关节点中。同时发起LeaderAndIsrRequest通知所有的replicas。
* leader来维护：leader有单独的线程定期检测ISR中follower是否脱离ISR, 如果发现ISR变化，则会将新的ISR的信息返回到Zookeeper的相关节点中。

![数据同步]({{ site.img_server }}/java/leader_follower_syn.png)

### 数据可靠性和持久性保证

> \# producer向leader发送数据时通过设置 
> request.required.acks 
> 参数来设置数据的可靠性级别:
> * 1(默认): producer在ISR中的leader接收到数据并确认后发送下一条message.(如果leader宕机,则数据会丢失)
> * 0   :producer无需等待broker确认继续发送下一批消息.(传输率高,可靠性低)
> * -1(all):producer需要等到ISR中的所有的follower度收到数据才算一次成功的发送.(可靠性最高,但是不能保证不丢数据,当只有一个leader没有备份时)


### leader选举

一条消息只有被所有的follower都从leader复制成功才认为该消息已经提交.这样确保了在leader宕机时没有被复制到follower中而造成数据丢失.


### Kafka的发送模式

> producer.type={sync,async}
> 设置同步或是异步的方式发送消息,同步的方式能够有较高的可靠性

异步模式下4个配套的参数(0.8中有部分参数)


名称                            | 描述
--------------------------------|------------
queue.buffering.max.ms          | 默认: 5000 .异步模式下,producer缓存消息的时间.例如设置为1000时,它会缓存1s在发送出去,这样可以增加broker的吞吐量,但是时效性会降低.
queue.buffering.max.message     | 


## 高可用性


### 消息传输保障

producer和consumer之间的传输保障有下面三种:

* At most once: 消息可能会丢,但绝不会重复传输 
* At lest once: 消息绝不会丢,单可能会重复传输
* Exactly once: 每条消息肯定会被传输一次仅仅一次

当producer向broker发送一条消息被commit后由于副本(replication)机制的存在,消息就不会丢失,但是当producer向broker发送消息后由于网络中断导致消息提交信息信号不能传送到producer导致producer进行消息重传以确保消息被成功接收.可以看到kafka采用的是At least once.

consumer从broker读取消息后,可以选择是否commit(注:*enable.auto.commit*),该操作会在Zookeeper中保存下该consumer在该partition下读取的消息的offset.该consumer下一次再读该partition是会从下一条开始读取.如为commit,下一次会更上一次commit之后的开始位置相同.

可能存在的情况:

* producer发送的消息重复
* consumer读完消息后先commit再处理消息,如果consumer在commit后还未处理消息就crash了,下一次就不会再读取该消息
* 读完消息后先处理再commit.如果处理完消息commit之前,consumer就crash了下一次重新开始还会处理为commit的消息.


### 消息去重

Kafka在producer端和consumer端都会出现消息重复.

Kafka文档中提及GUID(Globally Unique Identifier)的概念,通过producer客户端为每条消息生成 unique id, 同事可映射至broker上的存储地址,即通过GUID就能够提取消息内容,也便于发送消息的幂等性,(目前版本的支持待确定)

针对GUID如果从客户端角度去重,需要引入集中式缓存(不只是Kafka,类似的RabbitMQ以及RocketMQ也只保障 at lest once,且无法从自身进行消息去重)

## 高可靠性配置

Kafka的性能和可靠性需要针对自身的业务特点进行权衡选择.

高可靠性配置:

* topic配置: replication.factor>=3,即副本数至少3个; ``2<=min.insync.replicas<replication.factor((min.insyc.replicas:在broker设置如果小于该值那么producer将会抛出异常))``
* broker的配置:leader的选举条件unclean.leader.election.enable=false
* producer的配置:request.required.acks=-1(all),producer.type=sync


## BenchMark

# 参考链接

kafka数据可靠性深度解读:[http://www.importnew.com/24973.html](http://www.importnew.com/24973.html)  
kafka官网:[http://kafka.apache.org/documentation/](http://kafka.apache.org/documentation/)

