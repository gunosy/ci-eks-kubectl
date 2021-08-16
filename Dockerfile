ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

ARG KUBERNETES_VERSION
ARG RELEASE_VERSION
ARG KUSTOMIZE_VERSION

RUN : build dependencies \
    && apk --update --no-cache add ca-certificates python3 \
    && apk --no-cache add --virtual build-dependencies curl openssl \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && pip3 install --upgrade pip awscli \
    && : kubectl for eks \
    && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$KUBERNETES_VERSION/$RELEASE_VERSION/bin/linux/amd64/kubectl \
    && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$KUBERNETES_VERSION/$RELEASE_VERSION/bin/linux/amd64/kubectl.sha256 \
    && openssl sha1 -sha256 kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && rm -rf kubectl.sha256 \
    && : install kustomize \
    && curl -O -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$KUSTOMIZE_VERSION/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    && curl -O -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$KUSTOMIZE_VERSION/checksums.txt \
    && openssl sha1 -sha256 kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    && tar xzf kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    && chmod +x ./kustomize \
    && mv ./kustomize /usr/local/bin/kustomize \
    && rm -rf kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    && rm -rf checksums.txt \
    && : remove build dependencies \
    && apk del build-dependencies
