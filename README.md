# Unofficial Nessus Essential Scanner
<img src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge"> <img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white"> <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/ciro-mota/nessus-scanner?style=for-the-badge"> <img alt="Docker Image Size (tag)" src="https://img.shields.io/docker/image-size/ciromota/nessus-scanner/latest?style=for-the-badge">

Tenable's Nessus Scanner is a vulnerability scanner that looks for known vulnerabilities, configuration issues and more by inspecting hosts over the network. For more information about Nessus, see the following links:

[Nessus 8.11.x Docs](https://docs.tenable.com/nessus/Content/GettingStarted.htm)

## Requirements

- Docker or Podman.
- Debian Slim image Docker.
- License to use Nessus. You can get it [here](https://www.tenable.com/products/nessus/activation-code).

# Docker Support

## Build

- Clone this repository.
- Run the command: `docker image build -t ciromota/nessus-scanner:latest .`
- Or uncomment line 5 in `docker-compose.yml` for build and run.

## Usage

```bash
docker container run -td --name nessus-scanner -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus-scanner:latest
```
Or through docker-compose: `docker-compose up -d`

- Access `https://localhost:8834`

# Podman Support

[Podman](https://podman.io/) is a container engine for developing, managing and executing containers as an alternative to Docker.

## Build

- Clone this repository.
- Run the command: `podman build -t ciromota/nessus-scanner:latest -f .`

## Usage

```bash
podman run -td --name nessus -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus-scanner:latest
```
- Access `https://localhost:8834`

# Official Container

Tenable Nessus from version 8.x.x has its official container image.

https://hub.docker.com/r/tenableofficial/nessus