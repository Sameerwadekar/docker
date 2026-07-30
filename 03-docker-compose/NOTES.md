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
_(write what you actually understood here, in your own words)_

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
