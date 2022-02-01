# Unofficial Nessus Essential Scanner

<a href="https://github.com/ciro-mota/nessus-scanner/blob/main/README.pt-br.md"><img src="https://img.shields.io/badge/Versão-Português_Brasil-%2393CE0A?style=for-the-badge"></a> <img src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge" title="License of this scripts"> <img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white"> <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/ciro-mota/nessus-scanner?style=for-the-badge"> <img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/ciro-mota/nessus-scanner/Docker%20Nessus-Scanner%20CI?style=for-the-badge"> <img alt="Docker Image Size (tag)" src="https://img.shields.io/docker/image-size/ciromota/nessus-scanner/latest?style=for-the-badge">

Tenable's Nessus Scanner is a vulnerability scanner that looks for known vulnerabilities, configuration issues and more by inspecting hosts over the network. For more information about Nessus, see the following links:

[Nessus 8.11.x Docs](https://docs.tenable.com/nessus/Content/GettingStarted.htm)

# Requirements for build and use

- Docker, or Podman, or DockerSlim, or Containerd/nerdctl.
- Debian Slim image Docker.
- License to use Nessus. You can get it [here](https://www.tenable.com/products/nessus/activation-code).

You can safely inspect and use my already compiled image or build your own based on the instructions.

# Docker
## Build:

- Clone this repository.
- Run the command: `docker image build -t ciromota/nessus-scanner:latest .`
- Or uncomment line 5 in `docker-compose.yml` for build and run.

## Usage:

```bash
docker container run -td --name nessus-scanner -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus-scanner:latest
```
Or through docker-compose: `docker-compose up -d`.

- Access `https://localhost:8834`

# Podman

[Podman](https://podman.io/) is a container engine for developing, managing and executing containers as an alternative to Docker.

## Build:

- Clone this repository.
- Run the command: `podman build -t ciromota/nessus-scanner:latest -f .`
- Or uncomment line 5 in `docker-compose.yml` for build and run.

## Usage:

Practically the same as Docker.

```bash
podman run -td --name nessus -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus-scanner:latest
```
Or through docker-compose: `docker-compose up -d`.

- Access `https://localhost:8834`

# DockerSlim

[DockerSlim](https://github.com/docker-slim/docker-slim) brings a new experience in container management keeping its same workflow, producing a smaller and secure container.

Consult the documentation and learn about all its functions.

## Build and usage:

You can run DockerSlim on top of the previously built image and reduce the size of the Nessus Scanner image without harm, just use the command below:

```bash
docker-slim build ciromota/nessus
```

Or, it is possible with the help of DockerSlim itself to build a new image based on the Dockerfile file contained in this repo. Use the command below:

```bash
docker-slim build --dockerfile Dockerfile --show-blogs --tag ciromota/nessus.slim .
```

In both cases, you can run the container in the same way:

```bash
docker container run -td --name nessus -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus.slim
```
- Access `https://localhost:8834`

# nerdctl

nerdctl is a Docker-compatible CLI for contai**nerd**. Its syntax is basically the same used for Docker and Podman for example. Besides being rootless, it has other interesting functions, I recommend getting to [know it](https://github.com/containerd/nerdctl).

## Build:

- Clone this repository.
- Run the command (BuildKit will need to be installed first. See documentation.): `nerdctl image build -t ciromota/nessus-scanner:latest .`
- Or uncomment line 5 in `docker-compose.yml` for build and run: `nerdctl compose -f docker-compose.yml up -d`.

## Usage:

```bash
nerdctl run -d --name nessus-scanner -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus-scanner:latest
```
Or through docker-compose: `nerdctl compose up -d`

- Access `https://localhost:8834`

# Official Container

Tenable Nessus from version 8.x.x has its official container image.

https://hub.docker.com/r/tenableofficial/nessus