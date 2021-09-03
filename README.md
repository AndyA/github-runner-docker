# github-runner-docker


```sh
docker secret create github-ci-secret.sh secret.sh
```

```sh
export ARCH=arm
docker-compose build --build-arg ARCH=$ARCH
docker-compose push
docker stack deploy -c docker-compose.yml github-runner
```
