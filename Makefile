compose/up:
	docker compose -f ./docker/docker-compose.dev.yml -f ./docker/kong/kong.yaml up -d
