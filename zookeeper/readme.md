## About zookeeper

> ZooKeeper 是一个典型的分布式数据一致性解决方案，分布式应用程序可以基于 ZooKeeper 实现诸如数据发布/订阅、负载均衡、命名服务、分布式协调/通知、集群管理、Master 选举、分布式锁和分布式队列等功能。

- 分布式原理

  参考算法： Paxos
  
  集群间通过 Zab 协议（Zookeeper Atomic Broadcast）来保持数据的一致性
  
  Zab的重要概念
  - 崩溃恢复
    主节点离线不可用之后，集群会进入恢复模式，并选举产生新的Leader服务器，投票超过半数一致之后，即产生了新的Leader，然后退出恢复状态，进入消息广播状态

  - 消息广播
    主节点发起广播事务请求，半数节点确认之后，事务生效。

- 集群实现方法

  区别于 Mysql： Master/Slave 的角色
  节点角色：Leader（相应读写请求，负责更新整个系统的数据）、Follower（参与投票选举，响应读的请求，转发写的请求）、observer（响应读的请求，转发写的请求）所有节点之间相互通信，发送心率包



- 重要概念

  - zk是通过节点 `ZNode` 来保存数据的，类似 `/root/treeA/node1` 这种形式
  - 基于内存的，高速读写，更适用于`读 > 写`的场景，写的过程需要同步到所有其他的节点，所以会出现`STW`的情况，推荐不要使用过多的节点来集群，3个比较合适
  - 因为基于内存，所有每个节点存储的数据是有限制的，也不建议用于存放过多元数据
  - 节点 `ZNode` 分为 `Persistent Node` and `Temporarily Node`, PN一直存储在zk上，TN随着Session的释放也会同步释放
  - 节点的特殊属性 `SEQUENTIAL`， 可利用该属性，实现分布式锁的功能
  - 节点的版本 `Stat`
  - Watcher zk会向客户端推送节点的操作事件
  - ACL: C R W D A

- Feature

  - 顺序一致性
    
    通过创建一个全局唯一的自增 zxid( Zookeeper Transaction Id)， 可以理解为 时间戳。
  - Aoti

    所有事务请求的处理结果在整个集群中所有机器上的应用情况是一致的，也就是说，要么整个集群中所有的机器都成功应用了某一个事务，要么都没有应用。，
    只有Leader节点才能提供服务，保证原子性
  - 单一系统映像

    无论链接那个节点访问到的数据都是一样的
  - 可靠性

- 使用场景

  核心场景：注册发现中心
- 使用方法

  部署： 使用docker-compose
  cli: 参考[http://www.corejavaguru.com/bigdata/zookeeper/cli](http://www.corejavaguru.com/bigdata/zookeeper/cli)