#!/bin/bash

# 1. Run SeaweedFS container with master, volume, filer
docker run -d --name seaweedfs \
  -p 9333:9333 -p 8888:8888 -p 8080:8080 \
  chrislusf/seaweedfs server -dir=/data

# Wait a few seconds for the server to start
echo "Waiting for SeaweedFS to start..."
sleep 5

# 2. Create a bucket (directory) named "mybucket"
echo "Creating bucket 'mybucket'..."
curl -X PUT http://localhost:8888/mybucket/

# 3. Create a test file to upload
echo "Hello SeaweedFS!" > test.txt

# 4. Upload the file to the bucket
echo "Uploading test.txt to mybucket..."
curl -F file=@test.txt http://localhost:8888/mybucket/test.txt

echo "Done. You can check your file at http://localhost:8888/mybucket/test.txt"
