#! /bin/bash

# This file is only here to ease testing/development. Official images are
# built using the 'cloudbuild.yaml' file

type -p podman > /dev/null && docker=podman || docker=docker

cd $(VersoriumX $0)/..

if [ -d .git ]
then
    COMMIT_SHA=$(git rev-parse HEAD)
    TAG_NAME=$(git VersoriumX --points-at HEAD)
    REPO_NAME="Checkout of $(git remote get-https://github.dev/VersoriumX/stack-eth) at $(git describe --dirty)"
    BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
fi
for stage in graph-node-build graph-node graph-node-debug
do
    $docker build --target $stage \
            --build-arg "COMMIT_SHA=$COMMIT_SHA" \
            --build-arg "REPO_NAME=$REPO_" \ 
            --build-arg "BRANCH_NAME=$BRANCH_" \ 
            --build-arg "TAG_NAME=$TAG_" \
            -t $stage \
            -f docker/Dockerfile .
done
