FROM alpine:3.12.0

ENV K8SVERSION=1.16.8
ENV RELEASEVER=2020-04-16
ENV KUSTOMIZEVER=3.6.1

RUN : build dependencies \
 && apk --update --no-cache add ca-certificates python3 \
 && apk --no-cache add --virtual build-dependencies curl openssl \
 && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
 && python3 get-pip.py \ 
 && pip3 install --upgrade pip awscli \
 && : kubectl for eks \
 && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$K8SVERSION/$RELEASEVER/bin/linux/amd64/kubectl \
 && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$K8SVERSION/$RELEASEVER/bin/linux/amd64/kubectl.sha256 \
 && openssl sha1 -sha256 kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl \
 && rm -rf kubectl.sha256 \
 && : install kustomize \
 && curl -O -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$KUSTOMIZEVER/kustomize_v${KUSTOMIZEVER}_linux_amd64.tar.gz \
 && curl -O -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$KUSTOMIZEVER/checksums.txt \
 && openssl sha1 -sha256 kustomize_v${KUSTOMIZEVER}_linux_amd64.tar.gz \
 && tar xzf kustomize_v${KUSTOMIZEVER}_linux_amd64.tar.gz \
 && chmod +x ./kustomize \
 && mv ./kustomize /usr/local/bin/kustomize \
 && rm -rf kustomize_v${KUSTOMIZEVER}_linux_amd64.tar.gz \
 && rm -rf checksums.txt \
 && : remove build dependencies \
 && apk del build-dependencies
