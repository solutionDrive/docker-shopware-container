#!/usr/bin/env bash

declare -A KNOWNVERSIONS=(
    [5.5.0RC1]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.5.0_RC1_b3322a2c20d842371a3cef486540cbb0d8eece6f.zip
    [5.4.6]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.4.6_f667f6471a77bb5af0c115f3e243594e6353747e.zip
    [5.3.7]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.3.7_741ae9fb77ecb227dc6be9c1028ded1e957c0e14.zip
    [5.2.27]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.2.27_56d5aabc56c2e48d84084d0381a72a3897d5263f.zip
)

if [ -z "${KNOWNVERSIONS[$SHOPWARE_VERSION]}" ]; then
    echo "This script does not know how to get shopware ${SHOPWARE_VERSION}"
    echo "Please create a pull request at 'https://github.com/solutiondrive/docker-shopware-container' and"
    echo "provide an url to get the requested version!"
    exit 1
fi
SHOPWARE_URL=${KNOWNVERSIONS[$SHOPWARE_VERSION]}

if [ -z "${PROJECT_HOME}" ]; then
    echo "$$PROJECT_HOME must be set!"
    exit 1
fi

mkdir -p ${PROJECT_HOME}

DB_HOST=mysql
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=root
DB_DATABASE="getenv('MYSQL_DATABASE')"
CONFIG_FILE=${PROJECT_HOME}/config.php

echo "Everything is configured, starting setup:"
echo "PHP_VERSION: ${PHP_VERSION}"
echo "SHOPWARE_VERSION: ${SHOPWARE_VERSION}"
echo "SHOPWARE_URL: ${SHOPWARE_URL}"

cd ${PROJECT_HOME}

echo "Downloading shopware"
wget -q -O install.zip "${SHOPWARE_URL}"

echo "Unzipping install.zip"
unzip -q install.zip

# write config
printf '%s\n' ",s~'host' => '.*'~'host' => '${DB_HOST}'~g" w q | ed -s "${CONFIG_FILE}"
printf '%s\n' ",s~'port' => '.*'~'port' => '${DB_PORT}'~g" w q | ed -s "${CONFIG_FILE}"
printf '%s\n' ",s~'username' => '.*'~'username' => '${DB_USERNAME}'~g" w q | ed -s "${CONFIG_FILE}"
printf '%s\n' ",s~'password' => '.*'~'password' => '${DB_PASSWORD}'~g" w q | ed -s "${CONFIG_FILE}"
printf '%s\n' ",s~'dbname' => '.*'~'dbname' => ${DB_DATABASE}~g" w q | ed -s "${CONFIG_FILE}"

# install shopware including database
php recovery/install/index.php \
    --no-interaction \
    --quiet \
    --no-skip-import \
    --db-host="${DB_HOST}" \
    --db-user="${DB_USERNAME}" \
    --db-password="${DB_PASSWORD}" \
    --db-name="${MYSQL_DATABASE}" \
    --shop-locale="de_DE" \
    --shop-host="${WEB_HOST}" \
    --shop-path="" \
    --shop-name="Testshop" \
    --shop-email="sdadmin@sd.test" \
    --shop-currency="EUR" \
    --admin-username="sdadmin" \
    --admin-password="sdadmin" \
    --admin-email="sdadmin@sd.test" \
    --admin-name="sdadmin" \
    --admin-locale="de_DE"

chown -R www-data:www-data ${PROJECT_HOME}/
