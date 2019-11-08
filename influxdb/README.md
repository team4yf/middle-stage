## influxdb

### Demo

- import demo data:

`$ influx -import -path=/NOAA_data.txt -precision=s -database=NOAA_water_database`

- login in database

`$ influx -precision rfc3339 -database NOAA_water_database`

### Manual

[Query Manual](https://docs.influxdata.com/influxdb/v1.7/query_language/data_download/)

[Query Manual](https://docs.influxdata.com/influxdb/v1.7/query_language/data_exploration/)

### Warning

查询条件中的 单引号和双引号有很大的差别

- `SELECT "water_level" FROM "h2o_feet" WHERE "location" = 'santa_monica'`

```
Common issues with the WHERE clause
A WHERE clause query unexpectedly returns no data
In most cases, this issue is the result of missing single quotes around tag values or string field values. Queries with unquoted or double quoted tag values or string field values will not return any data and, in most cases, will not return an error.
```

```
> SELECT "water_level" FROM "h2o_feet" WHERE "location" = santa_monica          // nothing happend

> SELECT "water_level" FROM "h2o_feet" WHERE "location" = "santa_monica"    // nothing happend too

> SELECT "water_level" FROM "h2o_feet" WHERE "location" = 'santa_monica'    // it works
```

```
> SELECT "level description" FROM "h2o_feet" WHERE "level description" = "at or greater than 9 feet"    // nothing happend

> SELECT "level description" FROM "h2o_feet" WHERE "level description" = 'at or greater than 9 feet' // it works
```

where 条件中的 string 条件必须用 单引号包裹 ' 

### CQ 查询

`RESAMPLE EVERY 1h FOR 90m`

其中的 ERERY 表示，该查询会每个整点执行一次，查询范围是 now-90m ~ now 之间的数据，配合查询中的 group by time(30m)

每小时执行一次，并返回3条数据，具体实例如下：

```
CREATE CONTINUOUS QUERY "cq_advanced_every_for" ON "transportation"
RESAMPLE EVERY 1h FOR 90m
BEGIN
  SELECT mean("passengers") INTO "average_passengers" FROM "bus_data" GROUP BY time(30m)
END
```

```
>
At **8:00** `cq_advanced_every_for` executes a query with the time range `WHERE time >= '6:30' AND time < '8:00'`.
`cq_advanced_every_for` writes three points to the `average_passengers` measurement:
>
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T06:30:00Z   3
    2016-08-28T07:00:00Z   6.5
    2016-08-28T07:30:00Z   7.5
>
At **9:00** `cq_advanced_every_for` executes a query with the time range `WHERE time >= '7:30' AND time < '9:00'`.
`cq_advanced_every_for` writes three points to the `average_passengers` measurement:
>
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T07:30:00Z   7.5
    2016-08-28T08:00:00Z   11.5
    2016-08-28T08:30:00Z   16

```

#### sample

```
CREATE CONTINUOUS QUERY "cq_basic_2m" ON "NOAA_water_database"
BEGIN
  SELECT mean("index") INTO "average_quality" FROM "h2o_quality" GROUP BY time(2m)
END
```

influx -execute 'CREATE CONTINUOUS QUERY "cq_basic_2m" ON "NOAA_water_database" BEGIN SELECT mean("index") INTO "average_quality" FROM "h2o_quality" GROUP BY time(2m) END'

influx -execute 'SHOW QUERIES'