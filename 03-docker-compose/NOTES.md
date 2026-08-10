# Phase 3: Docker Compose

**Status:** Not started
**Dates:** 

## Topics to cover
- [ ] docker-compose.yml structure: services, build, image, ports, volumes, environment, depends_on
- [ ] How containers talk to each other by service name (not localhost)
- [ ] Running Spring Boot + React + MySQL together with one command
- [ ] Using .env files for config/secrets

## Things to search
- "docker-compose depends_on vs healthcheck"
- "docker compose networking service name"
- "docker-compose.yml spring boot mysql react example"
- "docker compose environment variables .env file"

## My notes
<!-- https://medium.com/@pavel.loginov.dev/wait-for-services-to-start-in-docker-compose-wait-for-it-vs-healthcheck-e0248f54962b -->
"docker-compose depends_on vs healthcheck" :
healthcheck are use to check health of the service and depend on tell other user to wait unitl the depedn on service image one.

How containers talk to each other by service name (not localhost)
docker comes with embedded DNS each container have there isolated network local host mean talking to the same container as docker container talk to each other with container name writing localhost will fail as it indicated talking to container itself rather than other container

-

## Things that confused me / took time to click
-

## My compose files
- `compose-practice/docker-compose.yml`

## Practice log
- [ ] Wrote docker-compose.yml with just MySQL
- [ ] Added Spring Boot service, connected it to MySQL via service name
- [ ] Added React service
- [ ] Ran full stack with `docker-compose up` — all 3 services talking to each other
- [ ] Used a `.env` file for DB credentials


https://medium.com/@thearaseng/building-a-full-stack-product-app-with-react-spring-boot-and-docker-compose-64a47f4a1080