#!/bin/bash
#echo off

nacos_ip=`docker inspect -f {{.NetworkSettings.Networks.solution_backnet.IPAMConfig.IPv4Address}} lens-nacos`


echo nacos_ip=$nacos_ip
nacos_user="nacos"
nacos_pass="lensson1"


getTokenResult=`curl --no-progress-meter -X POST http://$nacos_ip:8848/nacos/v1/auth/users/login -d "message=true&username=$nacos_user&password=$nacos_pass"`
echo getTokenResult=$getTokenResult
token=`echo $getTokenResult | yq -r '.accessToken'`
echo token=$token

infra_dir='infra'
blog_dir='blog'

$nacosConfigFile=$infra_dir+'/lens-gateway.yaml'
result=`curl --location --request POST 'http://nacos_ip:8848/nacos/v1/cs/configs?tenant=&accessToken=$token&username=$nacos_user&import=true&policy=ABORT' --form 'file=@"$nacosConfigFile"'`
echo result=$result
walk_dir () {
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            printf '%s\n' "$pathname"
        fi
    done
}

