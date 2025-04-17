#!/bin/bash

cd lens-blog
docker-compose -f lens-blog.yml down
cd ..

cd lens-infra
docker-compose -f lens-infra.yml down
cd ..

cd lens-nginx
docker-compose -f lens-nginx.yml down
cd ..

cd lens-rabbitmq
docker-compose -f lens-rabbitmq.yml down
cd ..

cd lens-zipkin
docker-compose -f lens-zipkin.yml down
cd ..

cd lens-nacos
docker-compose -f lens-nacos.yml down
cd ..

cd lens-mariadb
docker-compose -f lens-db.yml down
cd ..




