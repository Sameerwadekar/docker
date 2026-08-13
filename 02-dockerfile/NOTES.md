# Phase 2: Dockerfile

Status: done
Dates: August 3 2026 - August 6 2026

## Topics to cover
- [x] Dockerfile instructions: FROM, WORKDIR, COPY, RUN, EXPOSE, CMD/ENTRYPOINT
- [x] Multi-stage builds (build stage vs run stage)
- [x] Layer caching and why instruction order matters
- [x] Dockerizing Spring Boot (Maven build -> slim JRE runtime)
- [x] Dockerizing React (Node build -> nginx serve)

## Things to search
<!-- https://medium.com/@cat.edelveis/a-guide-to-docker-multi-stage-builds-for-spring-boot-08e3a64c9812 -->
- "Dockerfile multi-stage build Spring Boot"
<!-- https://medium.com/@vasanthancomrads/dockerfile-performance-optimization-best-practices-explained-25d85877f12b -->
- "Dockerfile best practices 2026"
- "COPY vs ADD Dockerfile"
- "docker build cache layer order"
- "dockerize React app nginx"

## My notes

COPY vs ADD Dockerfile :-
- COPY copies files/directories from local host into container image. Always use COPY for normal files.
- ADD does the same thing as COPY, but it can also auto-extract local tar/zip archives into target folder and download files from remote URLs. Use ADD only when tar extraction is needed.

docker build cache layer order :-
- Golden rule: place instructions from least frequently changed to most frequently changed.
- Docker builds line by line. When any line changes, docker invalidates cache from that line downwards and rebuilds all remaining steps.
- Example trick: Copy pom.xml or package.json first and run dependency install (mvn dependency:go-offline or npm install), THEN copy src folder. This way changes in java code won't trigger re-downloading all dependencies every time!

Multi-stage builds (Spring Boot & React) :-
- Multi-stage build allows us to build the app using heavy SDK image (Maven or Node), then copy only the final built JAR or build static files into a light runtime image (JRE or Nginx).
- Keeps image size tiny (reduces Spring Boot image from 800MB to ~150MB, React from 1GB to ~25MB).

Spring Boot Dockerfile example:
```dockerfile
# Stage 1: Build JAR using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -Dmaven.test.skip=true

# Stage 2: Run JAR using slim JRE
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

React Dockerfile example:
```dockerfile
# Stage 1: Build React static files
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve using Nginx
FROM nginx:1.25.1
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

CMD vs ENTRYPOINT :-
- CMD sets default command which can be easily overridden when running container (docker run image my-cmd).
- ENTRYPOINT configures container as a fixed binary executable.

## Things that confused me / took time to click
- syntax for multi-stage COPY: COPY --from=build /app/target/*.jar app.jar
- using JSON array format ["java", "-jar", "app.jar"] instead of raw string so stop signals work properly.

## Commands I practiced
```bash
# build spring boot image
docker build -t spring-boot-app:1.0 ./backend

# build react image
docker build -t react-web-app:1.0 ./frontend

# check build layers and history
docker history spring-boot-app:1.0

# check image sizes
docker images

# test running container
docker run -d -p 8080:8080 --name my-spring-app spring-boot-app:1.0
```

## Practice log
- [x] Wrote a basic single-stage Dockerfile
- [x] Wrote a multi-stage Dockerfile for Spring Boot
- [x] Wrote a multi-stage Dockerfile for React + nginx
- [x] Compared image sizes before/after multi-stage (reduced image size drastically!)
