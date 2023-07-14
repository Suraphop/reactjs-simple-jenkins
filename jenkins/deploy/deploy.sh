#!/bin/bash

echo "***************************"
echo "** deploy to production v.1.0.0***"
echo "***************************"

IMAGE="reactjs-project"

sshpass -p '1234' ssh -o StrictHostKeyChecking=no production@192.168.100.110 << ENDSSH
    docker login -u suraphop -p $PASS
    docker stop $IMAGE || true && docker rm $IMAGE || true
    docker pull suraphop/$IMAGE:$BUILD_TAG
    docker run --restart=always -d --publish 80:80 --name $IMAGE suraphop/$IMAGE:$BUILD_TAG 
ENDSSH
