# Phase 3: Docker Compose

Status: done
Dates: August 7 2026 - August 9 2026

## Topics to cover
- [x] docker-compose.yml structure: services, build, image, ports, volumes, environment, depends_on
- [x] How containers talk to each other by service name (not localhost)
- [x] Running Spring Boot + React + MySQL together with one command
- [x] Using .env files for config/secrets

## Things to search
<!-- https://medium.com/@pavel.loginov.dev/wait-for-services-to-start-in-docker-compose-wait-for-it-vs-healthcheck-e0248f54962b -->
- "docker-compose depends_on vs healthcheck"
- "docker compose networking service name"
- "docker-compose.yml spring boot mysql react example"
- "docker compose environment variables .env file"

## My notes

What is Docker Compose :-
- Docker Compose is a tool that allows us to run multi-container applications with a single YAML configuration file (docker-compose.yml).
- Instead of typing 3 long docker run commands manually for MySQL, Spring Boot and React, docker-compose up -d starts all of them together.

How containers talk to each other by service name (not localhost) :-
- Docker comes with embedded DNS inside user networks. Each container has its isolated network space.
- Writing localhost inside Spring Boot container points to Spring Boot itself! So connecting to MySQL on localhost will fail.
- To connect to MySQL from Spring Boot container, we must use the service name defined in docker-compose.yml (e.g. jdbc:mysql://mysql:3306/product).

docker-compose depends_on vs healthcheck :-
- depends_on only checks if container has started, not whether the app inside (like MySQL DB server) is ready to accept connections.
- healthcheck runs real check (like mysqladmin ping) to confirm service is healthy before starting dependent services.

Example docker-compose.yml structure (Spring Boot + React + MySQL):
```yaml
version: '3'

services:
  mysql:
    image: mysql:8.0
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_DATABASE: ${DB_NAME}
    volumes:
      - mysql_data:/var/lib/mysql

  spring-boot-app:
    build:
      context: ./backend
      dockerfile: Dockerfile
    ports:
      - "8080:8080"
    depends_on:
      - mysql
    environment:
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/${DB_NAME}
      SPRING_DATASOURCE_USERNAME: ${DB_USER}
      SPRING_DATASOURCE_PASSWORD: ${DB_PASSWORD}

  react-app:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    ports:
      - "3000:80"

volumes:
  mysql_data:
```

Environment variables with .env file :-
- Create a .env file next to docker-compose.yml for DB credentials so passwords are not hardcoded in compose file or committed to git repo.

## Things that confused me / took time to click
- port 3000:80 maps host port 3000 to nginx container port 80.
- difference between docker-compose down (removes containers/network) and docker-compose down -v (also deletes named volumes).

## Commands I practiced
```bash
# start all services in background
docker-compose up -d

# view running services
docker-compose ps

# check logs of all services or specific service
docker-compose logs -f
docker-compose logs -f spring-boot-app

# rebuild images and restart
docker-compose up -d --build

# stop containers and network
docker-compose down

# stop containers and wipe volumes
docker-compose down -v
```

## Practice log
- [x] Wrote docker-compose.yml with just MySQL
- [x] Added Spring Boot service, connected it to MySQL via service name (mysql:3306)
- [x] Added React service served via Nginx
- [x] Ran full stack with docker-compose up -d (all 3 services talking to each other)
- [x] Used a .env file for DB credentials

---
Reference: https://medium.com/@thearaseng/building-a-full-stack-product-app-with-react-spring-boot-and-docker-compose-64a47f4a1080