# Docker Interview Questions & Answers

Personal interview preparation notes for Java Full Stack Developer (Spring Boot + React + MySQL).

---

## 1. Core Concepts & Architecture

Q: What is the main difference between a Container and a Virtual Machine (VM)?
- Virtual Machines run a full guest operating system (with guest OS kernel, RAM, disk overhead) on top of a hypervisor (like VMware/VirtualBox). They are heavy, take minutes to start up, and consume high resources.
- Containers share the host OS kernel and run as isolated processes in user space. No guest OS overhead, start up in seconds/ms, and consume very little RAM/CPU.

Q: Explain Docker architecture.
- Docker Client (CLI tool): tool we type commands into (docker run, docker build).
- Docker Daemon (dockerd): background service on host OS that manages images, containers, networks, and volumes.
- Docker Images: static, read-only template/blueprint containing code, libraries, runtime.
- Docker Containers: running instance of an image with a thin read-write layer added on top.
- Docker Registry: centralized repository for storing and pulling images (e.g. Docker Hub).

Q: What is the difference between docker run and docker start?
- docker run creates a new container from an image and starts it.
- docker start starts an existing container that was stopped previously.

Q: What is the difference between docker ps and docker ps -a?
- docker ps shows currently running containers.
- docker ps -a shows all containers (running and stopped).

Q: How do Docker image layers work?
- Each instruction in a Dockerfile creates a read-only layer.
- Docker caches these layers. If a layer didn't change, Docker reuses it from cache during build, making builds very fast.
- Running a container adds a thin writable layer on top (container layer).

---

## 2. Dockerfile & Build Optimization

Q: Difference between COPY and ADD in Dockerfile?
- COPY copies local files/folders from host into container. Recommended for 95% of use cases.
- ADD does the same thing, but also auto-extracts local tar archives into target folder and can download files from remote URLs.
- Always use COPY unless tar extraction is required.

Q: Difference between CMD and ENTRYPOINT?
- CMD sets default command/args that can be overridden when running container (docker run image custom-cmd).
- ENTRYPOINT configures container as a fixed executable. Extra CLI args get appended to it.
- Always use JSON format ["java", "-jar", "app.jar"] so PID 1 signal handling works.

Q: What are Multi-Stage builds and why use them?
- Multi-stage build allows using multiple FROM statements in one Dockerfile.
- We can build app in first stage using heavy SDK image (Maven or Node), then copy only compiled JAR or static HTML build into a slim runtime image (JRE or Nginx).
- Keeps final image tiny (Spring Boot goes from ~800MB to ~150MB, React from ~1GB to ~25MB).

Q: How to optimize Docker build layer caching?
- Order instructions from least frequently changed to most frequently changed.
- Copy pom.xml or package.json first and run dependency download (mvn dependency:go-offline or npm install), THEN copy src code.
- This prevents re-downloading all dependencies every time a single line of code changes!

Q: What is .dockerignore used for?
- Excludes files like .git, node_modules/, target/, .env, logs from being sent to Docker daemon during build context, making builds faster and safer.

---

## 3. Volumes & Networking

Q: Difference between Named Volumes and Bind Mounts?
- Named Volume (-v mysql_data:/var/lib/mysql): Docker manages the storage folder under /var/lib/docker/volumes/. Best for production DB persistence.
- Bind Mount (-v $(pwd):/app): Mounts specific folder from host into container. Best for local development hot-reloading.

Q: Why does MySQL data disappear when container is removed?
- Files inside container are stored on a temporary container write layer that gets deleted with container.
- Fix: attach a named volume to /var/lib/mysql.

Q: Explain Docker Network drivers.
- bridge (default): private virtual network on host. Containers talk via IP or container service names.
- host: removes network isolation, container uses host network directly.
- none: disables all networking for complete isolation.

Q: Why localhost doesn't work between containers?
- Each container has its own loopback network interface (127.0.0.1). Calling localhost inside Spring Boot container tries to find MySQL inside Spring Boot container itself.
- Fix: connect both containers to same bridge network and use container service name (mysql:3306).

---

## 4. Docker Compose & Orchestration

Q: What is Docker Compose?
- Tool to run multi-container applications using a single docker-compose.yml file instead of running multiple manual docker run commands.

Q: Difference between depends_on and healthcheck in docker-compose.yml?
- depends_on only controls startup order (starts DB container before Spring Boot), but doesn't wait for DB server inside to finish initializing.
- healthcheck runs real check (e.g. mysqladmin ping or /actuator/health) to verify app is actually ready.
- Best practice: use depends_on with condition: service_healthy.

Q: How to pass secrets and environment variables in Compose?
- Put credentials in a .env file next to docker-compose.yml. Docker Compose automatically replaces ${VAR_NAME} placeholders. Add .env to .gitignore.

---

## 5. Spring Boot, Java & React Gotchas

Q: How does Spring Boot map environment variables to application.properties?
- Spring Boot has Relaxed Binding.
- spring.datasource.url -> SPRING_DATASOURCE_URL
- spring.datasource.username -> SPRING_DATASOURCE_USERNAME
- Replace dots . and hyphens - with underscores _ and convert to UPPERCASE.

Q: How to handle JVM memory inside Docker containers?
- Modern Java (11/17/21) is container aware. Use -XX:MaxRAMPercentage=75.0 flag instead of hardcoding -Xmx. This lets JVM scale heap dynamically based on container memory limits.

Q: How to serve React in production container?
- Multi-stage build: build static files using node:18 (npm run build), then copy build folder into nginx:alpine image to serve on port 80.

---

## 6. Practical Debugging Commands

Q: How to view logs of a running or failing container?
- docker logs -f --tail 100 <container_name>

Q: How to go inside a running container shell?
- docker exec -it <container_name> bash (or sh for Alpine)

Q: How to clean up unused Docker resources and free disk space?
- docker system prune -a --volumes -f
