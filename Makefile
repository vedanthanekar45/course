opensh:
	docker exec -it postgres-cont /bin/sh

postgres:
	docker run --name postgres-cont -p 5433:5432 -e POSTGRES_PASSWORD=root -d postgres:17.5-alpine

createdb:
	docker exec -it postgres-cont createdb --username=postgres --owner=postgres bank

dropdb:
	docker exec -it postgres-cont dropdb bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:root@localhost:5433/bank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:root@localhost:5433/bank?sslmode=disable" --verbose down

sqlc:
	sqlc generate

.PHONY: opensh postgres createdb dropdb migrateup sqlc