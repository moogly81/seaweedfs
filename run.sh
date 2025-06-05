#!/bin/bash
# This script runs SeaweedFS in a Docker container with the specified ports and volume.
curl -fsSL https://raw.githubusercontent.com/seaweedfs/seaweedfs/master/docker/seaweedfs-compose.yml > docker-compose.yaml

docker compose up -d
docker compose logs -f


aws configure --profile seaweedfs


#create bucket
aws --endpoint-url=http://localhost:8333 --profile seaweedfs s3 mb s3://my-bucket

# list buckets
aws --endpoint-url=http://localhost:8333 --profile seaweedfs s3 ls 

# create file
echo "Hello World" > myfile.txt

# upload file
aws --endpoint-url=http://localhost:8333 --profile seaweedfs s3 cp myfile.txt s3://my-bucket/

# stop and remove containers, networks, volumes, and images created by up
# docker compose down -v 
