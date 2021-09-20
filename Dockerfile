FROM ubuntu:18.04

# github runner version
ARG RV="2.283.1"
ARG ARCH="x64"
ARG BASE="https://github.com/actions/runner/releases/download"

RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

RUN apt-get install -y curl jq build-essential libssl-dev libffi-dev \
    python3 python3-venv python3-dev

RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L ${BASE}/v${RV}/actions-runner-linux-${ARCH}-${RV}.tar.gz \
    && tar xzf ./actions-runner-linux-${ARCH}-${RV}.tar.gz \
    && rm -f ./actions-runner-linux-${ARCH}-${RV}.tar.gz

RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

COPY start.sh start.sh

RUN chmod +x start.sh

USER docker

ENTRYPOINT ["./start.sh"]
