## filebeat

文件的监视器，可以搜集日志，推送到 es 中。


Manual: [https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-configuration.html](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-configuration.html)



```yml
filebeat:
  prospectors:
    - input_type: log
      paths:  # 这里是容器内的path
          - /var/log/command.log
      json.keys_under_root: true  # 使Filebeat解码日志结构化为JSON消息，设置key为输出文档的顶级目录。 如果不需要json格式输出，可以删除这两个json参数
      json.overwrite_keys: true # 覆盖其他字段
#   registry_file: /usr/share/filebeat/data/registry/registry  # 这个文件记录日志读取的位置，如果容器重启，可以从记录的位置开始取日志

output:
  elasticsearch:  # 我这里是输出到elasticsearch，也可以输出到logstash
    index: "rocket"  #  kibana中的索引
    hosts: ["es:9200"] # elasticsearch地址
```

Run Docker

```sh
docker run -d  --restart=always --name=filebeat \
-v /home/wangfan/Workspace/nodejs/rich/openiot.yunplus.io/app.log:/var/log/command.log:ro \
-v /home/wangfan/Workspace/elk/middle-stage/filebeat/filebeat.yml:/filebeat.yml \
prima/filebeat

-v /data/filebeat/registry/:/usr/share/filebeat/data/registry/ 
```