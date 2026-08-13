# Phase 6: Real Project — Dockerizing an Actual App

Status: done
Dates: August 12 2026 - August 13 2026

## Project being dockerized
Project: Full Stack React Product Management App (react-product-app)
- Tech Stack: Spring Boot 3 (Java 17 / Maven), React 18, MySQL 8.0
- Repo location: 03-docker-compose/react-product-app.zip

## What I did
- [x] Dockerized the backend (Spring Boot) using multi-stage build (Maven -> JRE)
- [x] Dockerized the frontend (React) using multi-stage build (Node -> Nginx)
- [x] Wrote docker-compose.yml combining backend + frontend + MySQL
- [x] Tested full stack running with a single command: docker-compose up -d
- [x] Configured environment variables with .env file
- [x] Pushed images to Docker Hub

## My notes (What worked, what broke, how I debugged it)

Backend Dockerfile (backend/Dockerfile):
```dockerfile
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY ./pom.xml /app
COPY ./src /app/src
RUN mvn clean package -Dmaven.test.skip=true

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

Frontend Dockerfile (frontend/Dockerfile):
```dockerfile
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.25.1
COPY .docker/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

docker-compose.yml:
```yaml
version: '3'

services:
  mysql:
    image: mysql:8.0
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: Sameer@123
      MYSQL_USER: sameer
      MYSQL_PASSWORD: Sameer@123
      MYSQL_DATABASE: product
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
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/product
      SPRING_DATASOURCE_USERNAME: sameer
      SPRING_DATASOURCE_PASSWORD: Sameer@123

  react-app:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    ports:
      - "3000:80"

volumes:
  mysql_data:
```

What broke & how I fixed it :-
1. Spring Boot started faster than MySQL DB initialization on first run, causing connection refused error.
   Fix: added autoReconnect=true in DB URL and restart: on-failure in compose.
2. CORS error from React frontend (port 3000) accessing Spring Boot backend (port 8080).
   Fix: added @CrossOrigin in Spring Boot controllers and configured Nginx proxy.

## Docker Hub links
- Backend image: sameerwadekar/spring-product-backend
- Frontend image: sameerwadekar/react-product-frontend

## LinkedIn post
- [x] Posted draft:

Completed my Docker Learning Journal! 🐳

Over the past few weeks, I built and containerized a full stack application (Spring Boot + React + MySQL) from scratch.

Here is what I completed across 6 phases:
- Phase 1: Docker Basics (Containers vs VMs, Architecture, core commands)
- Phase 2: Dockerfile & Multi-stage builds (reducing image sizes by over 70%)
- Phase 3: Docker Compose (orchestrating full stack apps with 1 command)
- Phase 4: Volumes & Networking (data persistence, container DNS)
- Phase 5: Spring Boot Gotchas (Relaxed binding env vars, Actuator health checks, JVM memory tuning)
- Phase 6: Real Project (Full-stack Product App dockerization end-to-end)

Check out my learning journal repo on GitHub: https://github.com/Sameerwadekar/docker

#Java #SpringBoot #React #Docker #DevOps #FullStack #LearningInPublic
