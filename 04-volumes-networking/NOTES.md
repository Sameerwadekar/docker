# Phase 4: Volumes & Networking

**Status:** Not started
**Dates:** 

## Topics to cover
- [X] Named volumes vs bind mounts
- [X] Why MySQL data disappears without a volume
- [ ] Docker bridge network basics
- [ ] Why `localhost` doesn't work between containers

## Things to search
https://medium.com/dev-sec-ops/docker-101-volume-bind-mounting-8f200c14ca0
- "docker named volume vs bind mount"
https://medium.com/@augustineozor/understanding-docker-bridge-network-6e499da50f65
- "docker bridge network explained"
- "why localhost doesn't work in docker container"
- "mysql docker volume data persistence"

## My notes
_(write what you actually understood here, in your own words)_

-

## Things that confused me / took time to click
-

## Practice log
- [ ] Ran MySQL without a volume, restarted container, confirmed data was lost
- [ ] Ran MySQL with a named volume, restarted container, confirmed data persisted
- [ ] Used a bind mount for local dev hot-reload
- [ ] Inspected a docker network with `docker network inspect`
