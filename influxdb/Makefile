all: docker

docker:
	docker-compose up -d

cli:
	docker exec -it influxdb sh -c "influx -precision rfc3339"

