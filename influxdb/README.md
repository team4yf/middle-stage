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
