up:
	docker compose up -d
down:
	docker compose down
down:
	docker compose down --remove-orphans
destroy:
	docker compose down --rmi all --volumes --remove-orphans
exec:
	docker compose exec db bash
psql-login:
	docker compose exec db bash ./psql-login.sh
