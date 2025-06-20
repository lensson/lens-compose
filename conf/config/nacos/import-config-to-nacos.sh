#!/bin/bash
#echo off

nacos_ip=`docker inspect -f {{.NetworkSettings.Networks.solution_backnet.IPAMConfig.IPv4Address}} lens-nacos`


echo nacos_ip=$nacos_ip

nacos_port=8848

nacos_user="nacos"
nacos_pass="nacos"


getTokenResult=`curl --no-progress-meter -X POST http://$nacos_ip:8848/nacos/v1/auth/users/login -d "message=true&username=$nacos_user&password=$nacos_pass"`
echo getTokenResult=$getTokenResult
token=`echo $getTokenResult | yq -r '.accessToken'`
echo token=$token

infra_dir='infra'
blog_dir='blog'
platfomr_dir='platform'

nacosConfigFile="${platfomr_dir}/lens-platform-gateway.yaml"
dataId="lens-platform-gateway"
#echo $nacosConfigFile
configContent=$(cat $nacosConfigFile)
#echo "configContent = ${configContent}"



result=`curl -X POST http://$nacos_ip:$nacos_port/nacos/v3/admin/cs/config?accessToken=$token -d "groupName=DEFAULT_GROUP&dataId=$dataId&content=$configContent&type=yaml"`

#result=`curl --location --request POST 'http://$nacos_ip:$nacos_port/nacos/v3/admin/cs/configs?tenant=&accessToken=$token&username=$nacos_user&import=true&policy=ABORT&groupName=public' --form 'file=@"$nacosConfigFile"'`

#curl --location --request POST 'http://172.28.0.1:8848/nacos/v3/admin/cs/config?tenant=&accessToken=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTc0NzYzNjg2OH0.u8tRz6QlsI-gbzDboIAr2Rgc1vUnMQfyVojRpDYONm8&username=nacos&import=true&namespace=docker&policy=ABORTnamespaceId=public&groupName=DEFAULT_GROUP&dataId=lens-platform-gateway' --form 'file=@"platform/lens-platform-gateway.yaml"'
#curl -X GET '172.28.0.1:8848/nacos/v1/cs/configs?accessToken=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTc0NzYzNjg2OH0.u8tRz6QlsI-gbzDboIAr2Rgc1vUnMQfyVojRpDYONm8&group=public'
#curl -X POST 'http://127.0.0.1:8848/nacos/v1/cs/configs' -d 'dataId=nacos.example&group=com.alibaba.nacos&content=contentTest'
#curl --location --request POST 'http://172.28.0.1:8848/nacos/v1/cs/configs?tenant=&accessToken=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTc0NzYzNjg2OH0.u8tRz6QlsI-gbzDboIAr2Rgc1vUnMQfyVojRpDYONm8&username=nacos&import=true&policy=ABORT' --form 'file=@"platform/lens-platform-gateway.yaml"'
#curl --location --request POST 'http://nacosip:8848/nacos/v1/cs/configs?import=true&namespace=public' --form 'policy=OVERWRITE' --form 'file=@"000"'
echo result=$result
#walk_dir () {
#    shopt -s nullglob dotglob
#
#    for pathname in "$1"/*; do
#        if [ -d "$pathname" ]; then
#            walk_dir "$pathname"
#        else
#            printf '%s\n' "$pathname"
#        fi
#    done
#}

