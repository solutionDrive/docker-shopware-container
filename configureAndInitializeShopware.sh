#!/usr/bin/env bash

if [ -z "${PROJECT_HOME}" ]; then
    echo "$$PROJECT_HOME must be set!"
    exit 1
fi

if [ -z "${DB_HOST}" ]; then
    DB_HOST=mysql
fi

if [ -z "${DB_PORT}" ]; then
    DB_PORT=3306
fi

if [ -z "${DB_USERNAME}" ]; then
    DB_USERNAME=root
fi

if [ -z "${DB_PASSWORD}" ]; then
    DB_PASSWORD=root
fi

if [ -z "${DB_DATABASE}" ]; then
    DB_DATABASE=test
fi

if [ -z "${WEB_HOST}" ]; then
    WEB_HOST=localhost
fi

CONFIG_FILE=${PROJECT_HOME}/config.php

ls -ahl /var/www

cd ${PROJECT_HOME}

if [ -z "${FORCE_INSTALL}" ]; then
    if [ -f recovery/install/data/install.lock ]; then
        echo "Installation already done! Skipping!"
        exit 0
    fi
fi

rm -f recovery/install/data/install.lock

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
    --db-name="${DB_DATABASE}" \
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
