#!/bin/bash

set -e -u

REGISTRY='us.gcr.io/container-suite'
VERSION=$CCP_IMAGE_TAG
IMAGES=(
    radondb-postgres-ha
    radondb-pgbadger
    radondb-pgbouncer
)

function echo_green() {
    echo -e "\033[0;32m"
    echo "$1"
    echo -e "\033[0m"
}

gcloud auth login
gcloud config set project container-suite
gcloud auth configure-docker

for image in "${IMAGES[@]}"
do
    echo_green "=> Pulling ${REGISTRY?}/${image?}:${VERSION?}.."
    docker pull ${REGISTRY?}/${image?}:${VERSION?}
    docker tag ${REGISTRY?}/${image?}:${VERSION?} radondb/${image?}:${VERSION?}
done

echo_green "=> Done!"

exit 0
