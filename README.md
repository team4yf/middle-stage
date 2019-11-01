## This is a Project for ELK & Influxdb & Grafana

### Content

- ELK
- InfluxDB & Grafana


#### ELK



#### IG

- Run Command: `$ npm run ig:start` .
- Stop Command: `$ npm run ig:stop` .
- Restart Command: `$ npm run ig:restart` .

###### InfluxDB

The Doc: [https://docs.influxdata.com/influxdb/v1.7/introduction/getting-started/](https://docs.influxdata.com/influxdb/v1.7/introduction/getting-started/)

Shell Into Influx Docker: `$ docker exec -it influxdb influx` .


###### Use http api init db

Manual: [https://docs.influxdata.com/influxdb/v1.7/tools/api/](https://docs.influxdata.com/influxdb/v1.7/tools/api/)

1) create db

`curl -i -XPOST http://localhost:19786/query --data-urlencode "q=CREATE DATABASE mydb"`

2) write point

`curl -i -XPOST 'http://localhost:19786/write?db=mydb' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64'`
