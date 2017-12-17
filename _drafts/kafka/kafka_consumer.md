

(**api-version: 10**)
## KafkaConsumer

```
org.apache.kafka.clients.consumer

Class KafkaConsumer<K,V>

All Implemented Interfaces:
java.io.Closeable, java.lang.AutoCloseable, Consumer<K,V>

```
consumer 客户端透明的处理从broker获取消息的失败信息,透明的适应在集群中获取集群中的主题内容.consumer客户端可以在consumer组中实现负载均衡.([consumer group](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/KafkaConsumer.html#consumergroups))

consumer维护着与broker之间的TCP链接以获取数据.未正确关闭consumer可能到这这些连接泄露.consumer客户端是非线程安全的(见:[多线程处理](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/KafkaConsumer.html#multithreaded)).

## 版本间的兼容性

该版本的consumer客户端可以和0.10.0或者更新的版本的broker进行通信.较新或者较旧版本的broker可能不支持某些特性.如果你企图调用的API不被当前正在运行的broker支持你可能会收到一个`UnsupportedVersionException`.

## 偏移量和消费位置

Kafka为每个partition维护一个数值类型的偏移量的值.这个偏移量是该分区的唯一标识符.也表示消费者在该分区的位置.例如,位于位置5的消费者已经消费了偏移量0~4位置的记录,接下来将会收到偏移量为5的那条记录. 实际上有两种与消费者用户有关的立场概念：

* consumer的位置代表了下一次将会被消费的记录.这个位置可能会比当前partition最大的偏移量要大.当消费者调用`poll(long)`获取消息后这个位置会自动增长.

* 提交位置是指最后被安全存储的记录的位置.当处理失败或者是重启时恢复的位置.consumer客户端可以指定是定期自动提交还是通过调用提交API(`commitSync`和`commitAsync`).

## 消费组和Topic订阅

Kafka使用消费组的概念来允许多个线程独立的处理记录.这些线程可以在一台主也可以被分开到不同的主机以提高系统的伸缩性和容错性.所有的消费实例使用同一个`group.id`来标识它们属于同一个消费组.

消费组里的每一个消费线程通过[subscribe](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/KafkaConsumer.html#subscribe-java.util.Collection-org.apache.kafka.clients.consumer.ConsumerRebalanceListener-)可以动态的设置他们想要订阅的topics.Kafka只会將订阅了某个topic的组中的一条信息仅仅发送给消费组中的一个消费者.这是通过平衡消费组之间的消费线程之间的分区来实现的,所以如果有一个topic有4个partition,消费组有两个消费线程,每一个消费线程将会处理两个partition.

消费组中的消费线程是动态管理的,如果一个线程产生异常,那么所有分配给它处理的partition将被重新指派给同组其它的消费线程.同样,如果有新的消费线程加入当前的消费组,那么会将其它消费线程处理的partition指派给新加入的消费消费线程.这就是我们所知道的负载均衡,[更详细的讨论](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/KafkaConsumer.html#failuredetection).组内的负载均衡被同样使用在当增加新的partition到订阅的topic或者是新的topic符合被[订阅](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/KafkaConsumer.html#subscribe-java.util.regex.Pattern-org.apache.kafka.clients.consumer.ConsumerRebalanceListener-)的规则.消费组将会自动的通过定期的更新元数据来检查新的partition并指定给组内的消费线程.

我们可以认为消费组是一个逻辑上的订阅者只不过他有多个消费的线程.作为一个支持多订阅的系统,Kafka自然的支持系统中的topic有任意多个消费组而不需要复制数据(添加额外的消费者其实是很便宜的一件事).

这是通常的消息系统中都有的功能.为了获得类似于传统消息传递系统中的队列的语义，所有进程将成为单个消费者组的一部分，需要被处理的记录在队列中采用负载均衡的策略来加快处理.不同于传统的消息系统,你可以有多个消费组.在传统的消息系统中为了实现`发布订阅`模式,每一个消费线程都有它所归属的消费组,所以每一个线程将会订阅发布到topic的每一条记录.

另外,当消费组内发生自动的重新分配,消费线程通过[ConsumerRebalanceListener](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/ConsumerRebalanceListener.html)被通知,这将允许他们完成必要的应用级逻辑,例如:状态清理,偏移量手动提交,等等.更多详细信息查看[Storing Offsets Outside Kafka](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/KafkaConsumer.html#rebalancecallback).

Kafka也允许为消费线程手动指定partition(类似于以前的"simple"消费者)使用[assign(Collection)](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/consumer/KafkaConsumer.html#assign-java.util.Collection-).这种情况下动态的partition指定和消费组内的线程协同将会失效.

## 检测消费者故障












































