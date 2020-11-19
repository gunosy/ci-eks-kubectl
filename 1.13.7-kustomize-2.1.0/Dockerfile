FROM alpine:latest

ENV K8SVERSION=1.13.7
ENV RELEASEVER=2019-06-11
ENV KUSTOMIZEVER=2.1.0

RUN : build dependencies \
 && apk --update --no-cache add ca-certificates py3-pip \
 && apk --no-cache add --virtual build-dependencies curl openssl \
 && pip3 install --upgrade pip awscli \
 && : kubectl for eks \
 && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$K8SVERSION/$RELEASEVER/bin/linux/amd64/kubectl \
 && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$K8SVERSION/$RELEASEVER/bin/linux/amd64/kubectl.sha256 \
 && openssl sha1 -sha256 kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl \
 && rm -rf kubectl.sha256 \
 && : install aws-iam-authenticator \
 && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$K8SVERSION/$RELEASEVER/bin/linux/amd64/aws-iam-authenticator \
 && curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/$K8SVERSION/$RELEASEVER/bin/linux/amd64/aws-iam-authenticator.sha256 \
 && openssl sha1 -sha256 aws-iam-authenticator \
 && chmod +x ./aws-iam-authenticator \
 && mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator \
 && rm -rf aws-iam-authenticator.sha256 \
 && : install kustomize \
 && curl -O -L https://github.com/kubernetes-sigs/kustomize/releases/download/v$KUSTOMIZEVER/kustomize_${KUSTOMIZEVER}_linux_amd64 \
 && curl -O -L https://github.com/kubernetes-sigs/kustomize/releases/download/v$KUSTOMIZEVER/checksums.txt \
 && openssl sha1 -sha256 kustomize_${KUSTOMIZEVER}_linux_amd64 \
 && chmod +x ./kustomize_${KUSTOMIZEVER}_linux_amd64 \
 && mv ./kustomize_${KUSTOMIZEVER}_linux_amd64 /usr/local/bin/kustomize \
 && rm -rf checksums.txt \
 && : remove build dependencies \
 && apk del build-dependencies
