# Phase 5: Spring Boot Specific Gotchas

**Status:** Not started
**Dates:** 

## Topics to cover
- [ ] Overriding application.properties with environment variables (SPRING_DATASOURCE_URL etc.)
- [ ] JVM memory settings inside containers
- [ ] Spring Actuator health checks + Docker HEALTHCHECK instruction
- [ ] Writing a proper .dockerignore for Maven/Node projects

## Things to search
- "spring boot docker application.properties override environment variable"
- "spring boot actuator health check docker"
- "JVM memory settings inside docker container"
- "dockerignore java maven node"

## My notes
_(write what you actually understood here, in your own words)_

-

## Things that confused me / took time to click
-

## Practice log
- [ ] Overrode DB URL using an env var instead of hardcoding in application.properties
- [ ] Added Actuator health endpoint, wired it into Docker HEALTHCHECK
- [ ] Set JVM memory flags and tested container behavior
- [ ] Wrote .dockerignore excluding target/, node_modules/, .git
