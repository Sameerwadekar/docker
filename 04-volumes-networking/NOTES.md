# Phase 4: Volumes & Networking

Status: done
Dates: August 9 2026 - August 11 2026

## Topics to cover
- [x] Named volumes vs bind mounts
- [x] Why MySQL data disappears without a volume
- [x] Docker bridge network basics
- [x] Why localhost doesn't work between containers

## Things to search
<!-- https://medium.com/dev-sec-ops/docker-101-volume-bind-mounting-8f200c14ca0 -->
- "docker named volume vs bind mount"
<!-- https://medium.com/@augustineozor/understanding-docker-bridge-network-6e499da50f65 -->
- "docker bridge network explained"
- "why localhost doesn't work in docker container"
- "mysql docker volume data persistence"

## My notes

Why MySQL data disappears without a volume :-
- Files created inside a container are saved on its temporary container write layer.
- When container is deleted (docker rm), that temporary layer gets destroyed. So all MySQL databases and tables get lost.
- To fix this, we attach Docker volumes to persist data outside the container lifespan.

Named Volumes vs Bind Mounts :-
- Named Volumes (-v mysql_data:/var/lib/mysql): Docker manages the volume folder (/var/lib/docker/volumes/). Great for production databases because Docker manages permissions and backup.
- Bind Mounts (-v $(pwd):/app): Mounts an exact path from host computer into container. Great for local development hot-reloading (React / Node / Java source code changes instantly reflect inside container).

Docker Bridge Network basics :-
- bridge network is default private network created on host.
- containers on same user-defined bridge network can communicate with each other using container names via built-in DNS.
- default bridge network doesn't support container name DNS out-of-the-box, but custom networks created via docker network create or docker compose do!

Why localhost doesn't work between containers :-
- Each container has its own isolated loopback interface (127.0.0.1).
- Calling localhost inside Spring Boot container tries to find MySQL inside Spring Boot container itself.
- Fix: attach both to custom network and call mysql:3306.

## Things that confused me / took time to click
- bind mount path on Linux needs full absolute path (using $(pwd) in terminal).
- default bridge vs custom bridge network difference in DNS lookup.

## Commands I practiced
```bash
# volume commands
docker volume create mysql_data
docker volume ls
docker volume inspect mysql_data
docker volume rm mysql_data

# run MySQL with volume for persistence
docker run -d --name mysql-db -e MYSQL_ROOT_PASSWORD=root -v mysql_data:/var/lib/mysql mysql:8.0

# run container with bind mount for hot-reload
docker run -d -p 3000:3000 -v $(pwd):/app react-app

# network commands
docker network create my-custom-network
docker network ls
docker network inspect my-custom-network

# run containers on custom network
docker run -d --name db --network my-custom-network mysql:8.0
docker run -d --name app --network my-custom-network spring-boot-app
```

## Practice log
- [x] Ran MySQL without a volume, destroyed container, confirmed data was lost
- [x] Ran MySQL with named volume (mysql_data), recreated container, confirmed data persisted
- [x] Used a bind mount for local dev code hot-reload
- [x] Inspected custom network with docker network inspect
