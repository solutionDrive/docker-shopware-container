#!/usr/bin/env bash

docker build \
    --build-arg PHP_VERSION=$PHP_VERSION \
    --build-arg SHOPWARE_VERSION=$SHOPWARE_VERSION \
    -t solutiondrive/docker-shopware-container:shopware$SHOPWARE_VERSION-php$PHP_VERSION \
    .

# Tag "latest"
if [ "$LATEST" = "1" ]; then
    docker tag \
        solutiondrive/docker-shopware-container:shopware$SHOPWARE_VERSION-php$PHP_VERSION \
        solutiondrive/docker-shopware-container:latest
fi
