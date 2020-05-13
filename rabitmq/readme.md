## About RabbitMQ

> RabbitMQ 是一个由 Erlang 语言开发的 AMQP 的开源实现。

- 消息持久化
- 集群部署 https://www.cnblogs.com/vipstone/p/9362388.html
- vhost 机制
- 消息确认实现的方法
  - 事务机制
  - 发送者确认机制

- 重要原则
  - 一个消息只会被一个client接受并处理，不会被每个处理
  - 消息接受到之后，返回一个条 ackonwledgment 给服务器，通知服务器移除该消息
  - mq没有收到回执前客户端断开了，则mq会把消息分给另外一个客户端处理，不存在timeout的概念，只要客户端没有断开，不会触发该机制
  - 消费完消息之后，务必要返回一条回执，否则会造成大量消息堆积的bug
  - publish message 是没有ACK的
  - 通过设置 Prefetch count = 1 则Queue每次给每个消费者发送一条消息， 消费者处理完这条消息后Queue会再给该消费者发送一条消息


#### docker hub

[https://registry.hub.docker.com/_/rabbitmq/](https://registry.hub.docker.com/_/rabbitmq/)


#### http api

- vhost

```
$ curl -i -u user:password -XGET localhost:15672/api/vhosts

$ curl -i -u user:password -H "content-type:application/json" -XPUT http://localhost:15672/api/vhosts/foo

$ curl -i -u user:password -H "content-type:application/json" -XPUT -d '{"type":"direct","auto_delete":false,"durable":true,"internal":false}' http://localhost:15672/api/exchanges/foo/default

$ curl -i -u user:password -H "content-type:application/json" -d '{"properties":{},"routing_key":"my key","payload":"my body","payload_encoding":"string"}' -XPOST http://localhost:15672/api/exchanges/foo/default/publish
```