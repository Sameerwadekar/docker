# Phase 1: Docker Basics

Status: done
Dates: July 31 2026 - August 2 2026

## Topics to cover
- [x] Containers vs Virtual Machines
- [x] What is a Docker image vs a container
- [x] Docker architecture (Engine, Daemon, CLI)
- [x] Core commands: docker run, ps, stop, rm, images, pull, exec -it, logs

## Things to search
- "docker vs virtual machine"
- "docker architecture explained"
- "docker run vs docker start difference"
- "docker ps vs docker ps -a"
- "what is a docker image layer"

## My notes
<!-- https://medium.com/@ravipatel.it/understanding-virtual-machines-vs-docker-containers-a-technical-comparison-241f370b2076 -->

Containers vs Virtual Machines :-
- docker containers are lightweight containers that directly talk to the host os kernel, making docker start super fast (in seconds or ms).
- virtual machines (like VMware or VirtualBox) need their own separate OS, kernel, RAM and CPU. VM runs on host OS which creates a double layer (app -> vm kernel -> host kernel), making startup very slow and taking up huge disk space.

docker architecture explained :-
- docker daemon : background service running on machine that manages docker images, containers, volumes, networks.
- docker client : command line tool (CLI) using which we run commands to talk to the docker daemon.
- docker images : read-only blueprint or template containing our app code, runtime, JDK/Node, libraries. It just sits on disk.
- docker containers : live running instance of an image. Consumes real RAM and CPU when running.
- docker registry : place where docker images are stored and shared, like Docker Hub (default public registry) or private registries.

docker run vs docker start difference :-
- docker run : creates a brand new container from an image and starts it. (e.g. docker run -d --name my-app -p 8080:8080 nginx)
- docker start : starts an existing container that was previously stopped.

docker ps vs docker ps -a :-
- docker ps : shows currently running containers only.
- docker ps -a : shows all containers (both running and stopped ones).

docker image layers :-
- docker images are built in layers. Every command written in Dockerfile creates a layer on top of previous layers.
- if a layer isn't changed, docker reuses it from cache, saving build time and disk space.

## Things that confused me / took time to click
- container stops immediately if the main process (PID 1) inside it finishes or exits.
- port mapping order: host port comes first, container port comes second (-p host:container).
- forgetting -d (detached mode) will block terminal output.

## Commands I practiced
```bash
# check docker status
docker version
docker info

# pull image from docker hub
docker pull nginx:latest

# list downloaded images
docker images

# run container in background with port mapping
docker run -d --name my-web-server -p 8080:80 nginx

# check running containers vs all containers
docker ps
docker ps -a

# view logs of running container
docker logs -f my-web-server

# go inside container shell
docker exec -it my-web-server bash

# stop and start existing container
docker stop my-web-server
docker start my-web-server

# remove container
docker rm -f my-web-server

# cleanup unused images and stopped containers
docker system prune -f
```

## Practice log
- [x] Pulled and ran hello-world
- [x] Pulled and ran nginx, accessed it in browser at localhost:8080
- [x] Pulled and ran mysql, connected to it via shell
- [x] Practiced starting/stopping/removing containers (start, stop, ps, ps -a, rm, logs)
