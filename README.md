# github-runner-docker


```sh
docker secret create github-ci-secret.sh secret.sh
```

```sh
docker-compose build --build-arg ARCH=arm
docker stack deploy -c docker-compose.yml -c docker-compose.dev.yml programme-index
```
