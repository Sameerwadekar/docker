# Phase 2: Dockerfile

**Status:** done
**Dates:** 

## Topics to cover
- [ ] Dockerfile instructions: FROM, WORKDIR, COPY, RUN, EXPOSE, CMD/ENTRYPOINT
- [ ] Multi-stage builds (build stage vs run stage)
- [ ] Layer caching and why instruction order matters
- [ ] Dockerizing Spring Boot (Maven build -> slim JRE runtime)
- [ ] Dockerizing React (Node build -> nginx serve)

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
COPY copies the directory to the folder both do same work but add also used to extract tar file in the folder withur leaving Only use ADD when you explicitly require its advanced automation capabilities. ADD also help tp exttract the remote image https while copy dont support it.

docker build cache layer order:
The golden rule for ordering Docker build cache layers is to place instructions from the least frequently changed to the most frequently changed.Docker processes Dockerfiles sequentially from top to bottom, creating a stack of image layers. When an instruction changes, its layer cache is invalidated, automatically forcing every single layer below it to rebuild from scratch, regardless of whether those lower layers changed or not.

refer cache example...


dockerize React app nginx:
extract the zip docker-with-nginx and learn it
-

## Things that confused me / took time to click
-

## My Dockerfiles
Put practice Dockerfiles in subfolders here, e.g.:
- `my-first-dockerfile/Dockerfile`
- `spring-boot-practice/Dockerfile`
- `react-practice/Dockerfile`

## Practice log
- [ ] Wrote a basic single-stage Dockerfile
- [ ] Wrote a multi-stage Dockerfile for Spring Boot
- [ ] Wrote a multi-stage Dockerfile for React + nginx
- [ ] Compared image sizes before/after multi-stage
