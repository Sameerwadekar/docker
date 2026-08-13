# Phase 5: Spring Boot Specific Gotchas

Status: done
Dates: August 11 2026 - August 12 2026

## Topics to cover
- [x] Overriding application.properties with environment variables (SPRING_DATASOURCE_URL etc.)
- [x] JVM memory settings inside containers (-XX:MaxRAMPercentage)
- [x] Spring Actuator health checks + Docker HEALTHCHECK instruction
- [x] Writing a proper .dockerignore for Maven/Node projects

## Things to search
- "spring boot docker application.properties override environment variable"
- "spring boot actuator health check docker"
- "JVM memory settings inside docker container"
- "dockerignore java maven node"

## My notes

Overriding application.properties with environment variables :-
- Spring Boot has Relaxed Binding built-in. Any key in application.properties can be overridden by environment variable passed to container.
- spring.datasource.url -> SPRING_DATASOURCE_URL
- spring.datasource.username -> SPRING_DATASOURCE_USERNAME
- spring.datasource.password -> SPRING_DATASOURCE_PASSWORD
- server.port -> SERVER_PORT
- Rule: change dots . and hyphens - to underscores _ and make uppercase. This allows building single Docker image and running in dev, test or prod by passing different env vars!

JVM memory settings inside containers :-
- Problem: Old Java versions didn't recognize container memory limits and saw full host RAM, leading to out-of-memory (OOM) kills.
- Fix: Modern Java (11/17/21) is container-aware. Use -XX:MaxRAMPercentage flag instead of hardcoding -Xmx.
```dockerfile
CMD ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
```

Spring Actuator health check + Docker HEALTHCHECK :-
- Include spring-boot-starter-actuator in pom.xml to expose /actuator/health.
- Configure Docker HEALTHCHECK in Dockerfile to ping this endpoint.
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
```

Writing a proper .dockerignore :-
- Just like .gitignore, .dockerignore excludes target/, node_modules/, .git, .idea/ from build context so docker build stays super fast.

Java Maven .dockerignore:
```
.git
target/
.mvn
.idea/
*.log
```

Node React .dockerignore:
```
.git
node_modules/
build/
.env.local
```

## Things that confused me / took time to click
- converting property keys to env var names (spring.jpa.hibernate.ddl-auto becomes SPRING_JPA_HIBERNATE_DDL_AUTO).
- if base image doesn't have curl, HEALTHCHECK using curl fails. Use wget or install curl.

## Commands I practiced
```bash
# override spring boot application properties via docker run -e
docker run -d -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/product \
  -e SPRING_DATASOURCE_USERNAME=sameer \
  -e SPRING_DATASOURCE_PASSWORD=Sameer@123 \
  spring-boot-app:1.0

# run container with RAM cap
docker run -d --memory="512m" spring-boot-app:1.0

# check container health status
docker ps
```

## Practice log
- [x] Overrode DB URL using env var instead of hardcoding in application.properties
- [x] Added Actuator health endpoint, wired it into Docker HEALTHCHECK
- [x] Set JVM memory flags (-XX:MaxRAMPercentage=75.0) and tested container behavior
- [x] Wrote .dockerignore excluding target/, node_modules/, .git
