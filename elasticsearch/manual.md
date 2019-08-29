# 使用 docker 运行 es

[https://hub.docker.com/_/elasticsearch?tab=description](https://hub.docker.com/_/elasticsearch?tab=description)

```sh
docker network create es-network
docker run -d --name es --net es-network -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.3.1
```


### 常用的语句

空查询，查看所有数据
```
curl -X GET "localhost:9200/_search?pretty"
```

### 相关介绍

可以将其理解为一个 支持 RESTFUL 操作的文档数据库，比 NOSQL 数据库更友好的地方是：客户端丰富，复杂的查询。



### Learn

Day1: [https://www.elastic.co/guide/cn/elasticsearch/guide/current/combining-filters.html](https://www.elastic.co/guide/cn/elasticsearch/guide/current/combining-filters.html)

