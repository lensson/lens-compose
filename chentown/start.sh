#!/bin/bash

cd lens-mariadb
docker-compose -f lens-db.yml up&
cd ..

cd lens-zipkin
docker-compose -f lens-zipkin.yml up&
cd ..

cd lens-rabbitmq
docker-compose -f lens-rabbitmq.yml up&
cd ..

cd lens-nacos
docker-compose -f lens-nacos.yml up&
cd ..

cd lens-nginx
docker-compose -f lens-nginx.yml up&
cd ..

cd lens-infra
docker-compose -f lens-infra.yml up&
cd ..

