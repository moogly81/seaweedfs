# SeaweedFS with Docker and AWS CLI

This guide walks you through setting up [SeaweedFS](https://github.com/seaweedfs/seaweedfs) using Docker Compose, configuring AWS CLI to interact with it, and performing basic S3-compatible operations.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [AWS CLI](https://aws.amazon.com/cli/)

## Step 1: Run SeaweedFS via Docker Compose

Download the official `docker-compose` file and start the containers:

```bash
curl -fsSL https://raw.githubusercontent.com/seaweedfs/seaweedfs/master/docker/seaweedfs-compose.yml > docker-compose.yaml

docker compose up -d
docker compose logs -f
```

## Step 2: Configure AWS CLI

Configure a dedicated AWS CLI profile (e.g., `seaweedfs`) to use with the local SeaweedFS S3-compatible endpoint:

```bash
aws configure --profile seaweedfs
```

You can provide dummy credentials (e.g., `accessKey` and `secretKey`) since it's running locally.

## Step 3: Create an S3 Bucket

Use the S3-compatible API to create a bucket:

```bash
aws --endpoint-url=http://localhost:8333 --profile seaweedfs s3 mb s3://my-bucket
```

## Step 4: List Buckets

```bash
aws --endpoint-url=http://localhost:8333 --profile seaweedfs s3 ls
```

## Step 5: Upload a File

```bash
echo "Hello World" > myfile.txt

aws --endpoint-url=http://localhost:8333 --profile seaweedfs s3 cp myfile.txt s3://my-bucket/
```

## Optional: Stop and Clean Up

To stop and remove all containers, networks, volumes, and images created by Docker Compose:

```bash
docker compose down -v
```

---

## References

- [SeaweedFS GitHub Repository](https://github.com/seaweedfs/seaweedfs)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
