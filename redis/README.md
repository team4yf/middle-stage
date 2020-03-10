## redis 

### Content

- Data Struct
- Cli Command
- Client SDK
- Data Persistence
- Config
- Cluster Deploy

#### Data Struct

- String
- List
- HashMap
- Set
- Sorted Set

#### Cli Command

See [Command](https://www.cnblogs.com/lizhenghn/p/5322887.html)

#### Data Persistence


See [Data Persistence][https://www.liumapp.com/articles/2019/09/11/1568193356679.html]

[Official Manual](https://redislabs.com/ebook/part-2-core-concepts/chapter-4-keeping-data-safe-and-ensuring-performance/4-1-persistence-options/4-1-3-rewritingcompacting-append-only-files/)

#### Config

```conf
requirepass admin123

#save 60 1000
stop-writes-on-bgsave-error no
rdbcompression no
dbfilename dump.rdb

appendonly yes
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb

dir /data/
```