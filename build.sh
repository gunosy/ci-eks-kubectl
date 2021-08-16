#!/bin/sh
set -eu

tail -n +2 versions.txt | awk 1 | \
while read -r ALPINE_VERSION KUBERNETES_VERSION RELEASE_VERSION KUSTOMIZE_VERSION; do
    TAG="${KUBERNETES_VERSION}-kustomize-${KUSTOMIZE_VERSION}"
    cat <<EOF
build $TAG
ALPINE_VERSION=$ALPINE_VERSION
KUBERNETES_VERSION=$KUBERNETES_VERSION
RELEASE_VERSION=$RELEASE_VERSION
KUSTOMIZE_VERSION=$KUSTOMIZE_VERSION
EOF

    docker build . -t "gunosy/ci-eks-kubectl:$TAG" \
        --build-arg ALPINE_VERSION="$ALPINE_VERSION" \
        --build-arg KUBERNETES_VERSION="$KUBERNETES_VERSION" \
        --build-arg RELEASE_VERSION="$RELEASE_VERSION" \
        --build-arg KUSTOMIZE_VERSION="$KUSTOMIZE_VERSION"
    docker push "gunosy/ci-eks-kubectl:$TAG"

    echo -e "\n\n"
done
