
#!/bin/bash

arch=$( uname -m )

case $arch in
  armv7l)
    ARCH=arm
    ;;
  arm64)
    ARCH=arm64
    ;;
  x86_64)
    ARCH=x86
    ;;
  *)
    echo "Unknown arch: $arch" 1>&2
    exit 1
    ;;
esac

export ARCH
echo "Build for $ARCH"

docker-compose build --build-arg ARCH=$ARCH
docker-compose push
docker stack deploy -c docker-compose.yml github-runner

