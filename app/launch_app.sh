#!/bin/bash

docker network create reseau 

docker container run --name script -d --rm --network reseau -v $(pwd)/src/:/var/www/html/ php:8.3.7-fpm 

docker container run -v $(pwd)/src/:/var/www/html/ -v $(pwd)/conf/default.conf:/etc/nginx/conf.d/default.conf --name http -p 8080:80 --network reseau -d --rm nginx:1.25


cd ../swarm

./launch_swarm.sh