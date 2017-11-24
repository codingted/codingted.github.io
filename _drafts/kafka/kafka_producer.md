## 生产者基本信息

```
org.apache.kafka.clients.producer
Class KafkaProducer<K,V>

java.lang.Object
org.apache.kafka.clients.producer.KafkaProducer<K,V>
All Implemented Interfaces:
java.io.Closeable, java.lang.AutoCloseable, Producer<K,V>

```

Kafka客户端发送消息到Kafka集群.

producer是线程安全的在多线程下共享一个实例要比多个实例有更高的效率.

## 简单实例

```
 Properties props = new Properties();
 props.put("bootstrap.servers", "localhost:9092");
 props.put("acks", "all");
 props.put("retries", 0);
 props.put("batch.size", 16384);
 props.put("linger.ms", 1);
 props.put("buffer.memory", 33554432);
 props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
 props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

 Producer<String, String> producer = new KafkaProducer<>(props);
 for (int i = 0; i < 100; i++)
     producer.send(new ProducerRecord<String, String>("my-topic", Integer.toString(i), Integer.toString(i)));

 producer.close();
```

生产者由一系列的缓冲区组成,这些缓冲区用来缓冲暂时没有发送到server的消息,后台的I/O线程负责將记录发送到kafka集群.不正常的关闭生产者可能导致丢失这些记录.

[send()](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/producer/KafkaProducer.html#send-org.apache.kafka.clients.producer.ProducerRecord-)方法是异步的.当调用该方法发送消息时会立即返回.这就是的生产者可以搞笑的批量处理记录.

*acks*控制请求如何被确认为完成.acks被设置为"all"说明当producer收到kafka集群的确认之前將一直发生祖塞,这样会损失一些效率但是保证了系统的可用性.

当记录发送失败,producer可以自动重发,但是如果配置*retries*为0则不会.启用重发机制又有可能导致消息重复(参见:[消息发送](http://kafka.apache.org/documentation.html#semantics))

生产者维护着发送到kafka集群分区的未分配消息的缓冲区.这些缓冲区的大小又*batch.size*配置,缓冲区过大会使批处理更多的数据,但是相应的也需要更多的内存(因为我们会对每一个活动的分区使用一个缓冲区);

默认缓冲区中的内容是被立即发送的(即使还有未被使用的空间).如果想要减少记录发送的次数可以设置*linger.ms*参数为大于0的值,这有点类似于[纳格算法](https://zh.wikipedia.org/wiki/%E7%B4%8D%E6%A0%BC%E7%AE%97%E6%B3%95)在tcp中的应用.在配置了*linger.ms*可能会使在1毫秒中到达100条记录一次发送到server端,当然如果缓存还没有被填满,我们可以把值多加1毫秒可以等待更多的到达的记录.当我们配置该值为0时,还是有可能在短时间内接收到超过一条的记录并同时將他们发送出去,这就类似于设置该值大于0的情况.但是在高负载的情况下设置该值为合适的值是可以提高我们发送记录的效率,只是付出了一些消息延迟的代价.

*buffer.memory*控制缓存和用的最大内存.如果记录发送的速度大于发送到server的速度会导致缓存空间枯竭.后续到来的记录将会被祖塞.祖塞时间的阈值有*max.block.ms*来设置,超过改时间将会抛出`TimeoutException`异常.

*key.serializer*和*value.serializer*设置key和value发送时的结构.可以使用`ByteArraySerializer` 或者`StringSerializer`来处理简单的字符串或者byte数组.(处理中文乱码)

## 幂等&事务
Kafka 0.11之后的版本额外提供了两种模式:幂等和事务生产者.幂等的生产者將至少一次加强到只有一次交付.在这种情况下生产者重试将不会引入重复.事务性生产者將允许应用自动的將消息发送到多个不同的分区(不同的主题).

开启幂等性生产者需要设置*enable.idempotence*为true.设置好之后*retries*默认将会是**Integer.MAX_VALUE**.(当producer发生无限重试时,建议关闭producer,进行检查)

如果要使用事务性生产者及API需要设置*transactional.id*,该值被设置幂等性也会被相应的开启.被包含到事务性生产者的topics应该被设置为高可用.*replication.factor*应该至少设置为3,并且*min.insync.replicas*被设置为2.最后为了保证事务的在端到端的正确执行,consumer必须被配置为只能读取已经提交的消息.

*transactional.id*可以用来恢复一个生产者跨越多个session的问题.*transactional.id*在多个分片/应用中被共享,因此这个值在整个应用中应该是唯一的.

在新的事务API是阻塞式的并且在处理失败时会抛出异常.

**例子**

```
Properties props = new Properties();
 props.put("bootstrap.servers", "localhost:9092");
 props.put("transactional.id", "my-transactional-id");
 Producer<String, String> producer = new KafkaProducer<>(props, new StringSerializer(), new StringSerializer());

 producer.initTransactions();

 try {
     producer.beginTransaction();
     for (int i = 0; i < 100; i++)
         producer.send(new ProducerRecord<>("my-topic", Integer.toString(i), Integer.toString(i)));
     producer.commitTransaction();
 } catch (ProducerFencedException | OutOfOrderSequenceException | AuthorizationException e) {
     // We can't recover from these exceptions, so our only option is to close the producer and exit.
     producer.close();
 } catch (KafkaException e) {
     // For all other exceptions, just abort the transaction and try again.
     producer.abortTransaction();
 }
 producer.close();

```

示例中暗示我们一个producer只能有一个事务.所有的在`beginTransaction()`和`commitTransaction()`之间的部分被视为一个事务.当*transactional.id*被声明,所有被producer发送的消息应该是事务的一部分.

事务性生产者使用异常来传递错误消息.不需在返回`KafkaException`异常时,为producer.send()声明callback方法或者调用get()方法.查看详情[send(ProducerRecord)](http://kafka.apache.org/10/javadoc/org/apache/kafka/clients/producer/KafkaProducer.html#send-org.apache.kafka.clients.producer.ProducerRecord-).

通过调用`producer.abortTransaction()`方法可以确保所有被成功写入的记录不被标识为终止.

事务性生产者可以提交消息到0.10.0或者更高版本的broker.低版本的broker可能不支持客户端该特性.所以事务API需要broker版本为0.11.0或者更高的版本.当你调用不被broker支持的api会抛出`UnsupportedVersionException`

