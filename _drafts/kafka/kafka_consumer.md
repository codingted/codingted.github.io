

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
















































