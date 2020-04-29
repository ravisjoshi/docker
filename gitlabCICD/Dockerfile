FROM docker:git

MAINTAINER joshi.ravishankar@gmail.com
WORKDIR /root/
ENV HELM_VERSION="v3.2.0"

RUN apk update \
    && apk add ca-certificates wget openssl curl \
    && update-ca-certificates \
    && cd /opt \
    && apk -q add python \
    && apk add --update libintl \
    && apk add --virtual build_deps gettext \
    && cp /usr/bin/envsubst /usr/local/bin/envsubst \
    && apk del build_deps \
    && rm -rf /var/cache/apk/* \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

RUN mkdir /root/.kube /root/.docker
COPY config /root/.kube/config
COPY config.json /root/.docker/config.json
