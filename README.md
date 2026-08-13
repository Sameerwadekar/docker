# Docker Learning Journal 🐳

Learning Docker in public — as a Java Full Stack Developer (Spring Boot + React + MySQL).

This repository documents my complete self-learning journal: research notes, hands-on practice, multi-stage Dockerfiles, Docker Compose setups, troubleshooting steps, and interview preparation.

---

## 🎯 Background & Goal

I am a Java Full Stack Developer (Spring Boot, React, MySQL) with ~6 months of experience. I built this repository to master containerization, learn how to package full-stack applications cleanly, and make my projects deployment-ready.

---

## 🚀 Learning Roadmap & Progress

- [x] Phase 1: Docker Basics — Containers vs VMs, Architecture, Core CLI
- [x] Phase 2: Dockerfile — Build Instructions, Layer Caching, Multi-Stage Builds
- [x] Phase 3: Docker Compose — Multi-Container Orchestration (Spring Boot + React + MySQL)
- [x] Phase 4: Volumes & Networking — Data Persistence & Container DNS
- [x] Phase 5: Spring Boot Specific Gotchas — Config, Health Checks, JVM Tuning
- [x] Phase 6: Real Project — End-to-End Dockerization & Docker Hub Deployment

---

## 💡 What I Learned (Phase by Phase)

### 🔹 Phase 1: Docker Basics
- Understood the difference between Virtual Machines (heavy OS overhead) and Docker Containers (lightweight processes sharing host OS kernel).
- Mastered Docker architecture: Docker Client, Docker Daemon (`dockerd`), Images, Containers, and Docker Hub Registry.
- Practiced core CLI commands: `docker run`, `docker ps`, `docker ps -a`, `docker exec -it`, `docker logs`, `docker stop`, `docker rm`.

### 🔹 Phase 2: Dockerfile & Multi-Stage Builds
- Learned Dockerfile directives: `FROM`, `WORKDIR`, `COPY`, `RUN`, `EXPOSE`, `CMD`, `ENTRYPOINT`.
- Understood `COPY` vs `ADD` and layer caching optimization (ordering instructions from least to most frequently changed).
- Built multi-stage Dockerfiles for Spring Boot (Maven SDK -> Temurin JRE) and React (Node build -> Nginx serve), cutting final image sizes by over 70%.

### 🔹 Phase 3: Docker Compose
- Created `docker-compose.yml` to launch Spring Boot, React, and MySQL together with a single `docker-compose up -d` command.
- Understood container DNS: why containers talk using service names (e.g. `jdbc:mysql://mysql:3306/product`) instead of `localhost`.
- Handled container startup ordering using `depends_on` and `healthcheck`, and managed secrets securely using `.env` files.

### 🔹 Phase 4: Volumes & Networking
- Solved database data loss by understanding ephemeral container layers vs persistent storage.
- Practiced Named Volumes (for production DB persistence) vs Bind Mounts (for local dev code hot-reloading).
- Explored Docker network drivers (`bridge`, `host`, `none`) and verified inter-container connectivity using `docker network inspect`.

### 🔹 Phase 5: Spring Boot Specific Gotchas
- Overrode `application.properties` dynamically using Spring Boot Relaxed Binding (`SPRING_DATASOURCE_URL`, `SPRING_DATASOURCE_USERNAME`).
- Fixed container OOM crashes by setting container-aware JVM memory flags (`-XX:MaxRAMPercentage=75.0`).
- Integrated Spring Boot Actuator (`/actuator/health`) with Docker `HEALTHCHECK` instructions.
- Created proper `.dockerignore` files for both Java Maven and React Node projects.

### 🔹 Phase 6: Real Project (Full-Stack Product Management App)
- Containerized an actual full-stack app (`react-product-app`) containing Spring Boot 3, React 18, and MySQL 8.0.
- Resolved database initialization race conditions and CORS browser policies between frontend and backend.
- Published built images to Docker Hub registry (`sameerwadekar/spring-product-backend` and `sameerwadekar/react-product-frontend`).

---

## 📂 Repository Structure

```
docker-learning-journal/
├── README.md
├── DOCKER_INTERVIEW_QUESTIONS.md   <-- 24 Key Docker Interview Q&A
├── 01-docker-basics/               <-- Notes & CLI practice
├── 02-dockerfile/                  <-- Single & Multi-stage Dockerfiles
├── 03-docker-compose/              <-- docker-compose.yml & Full Stack App
├── 04-volumes-networking/          <-- Volume persistence & bridge networks
├── 05-spring-boot-gotchas/          <-- JVM memory, Actuator & env vars
└── 06-real-project/                <-- Real project Dockerization writeup
```

---

## 📘 Docker Interview Quick Revision

Check out [`DOCKER_INTERVIEW_QUESTIONS.md`](DOCKER_INTERVIEW_QUESTIONS.md) in the root folder for a curated collection of 24 interview questions and practical answers covering Core Concepts, Dockerfiles, Volumes, Networking, Compose, and Spring Boot / React gotchas!

---

## ⭐️ Why This Repo Exists

Learning in public! Instead of watching tutorials passively, I documented everything in my own words with hands-on practice code and real commit history to build strong DevOps foundations for full-stack development.
