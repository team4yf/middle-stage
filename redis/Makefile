all: redis

install:
	pip install redis

insert:
	python3 insert.py

redis:
	docker-compose up -d

redis-cli:
	docker exec -it redis-server sh -c "redis-cli -a admin123"

