#!/usr/bin/env bash

ATTRIBUTES_TEMPLATE_FILE="tests/inspec/shopware-container/attributes.yml.template"
ATTRIBUTES_FILE="tests/inspec/shopware-container/attributes.yml"
cp ${ATTRIBUTES_TEMPLATE_FILE} ${ATTRIBUTES_FILE}
printf '%s\n' ",s~{{ shopware_short_version }}~${SHOPWARE_SHORT_VERSION}~g" w q | ed -s "${ATTRIBUTES_FILE}"
printf '%s\n' ",s~{{ php_short_version }}~${PHP_SHORT_VERSION}~g" w q | ed -s "${ATTRIBUTES_FILE}"

DOCKER_CONTAINER_ID=`docker run -d solutiondrive/docker-shopware-container:shopware$SHOPWARE_VERSION-php$PHP_VERSION`
inspec exec tests/inspec/shopware-container --attrs tests/inspec/shopware-container/attributes.yml -t docker://${DOCKER_CONTAINER_ID}
docker stop ${DOCKER_CONTAINER_ID}
