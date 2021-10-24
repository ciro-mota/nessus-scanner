# Nessus Essential Scanner (não oficial)
<img src="https://img.shields.io/badge/Licença-GPLv3-blue.svg?style=for-the-badge"> <img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white"> <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/ciro-mota/nessus-scanner?style=for-the-badge"> <img alt="Docker Image Size (tag)" src="https://img.shields.io/docker/image-size/ciromota/nessus-scanner/latest?style=for-the-badge">

O Nessus Scanner da Tenable é um scanner de vulnerabilidades que procura vulnerabilidades conhecidas, problemas de configuração e muito mais, inspecionando hosts na rede. Para obter mais informações sobre o Nessus, consulte o seguinte link:

[Nessus 8.11.x Docs](https://docs.tenable.com/nessus/Content/GettingStarted.htm)

## Requerimentos

- Docker ou Podman ou Docker Slim.
- Imagem Docker do Debian Slim.
- Licença de uso do Nessus. Você pode conseguir isso [aqui](https://www.tenable.com/products/nessus/activation-code).

# Suporte ao Docker

## Construção

- Clone este repositório.
- Execute este comando: `docker image build -t ciromota/nessus-scanner:latest .`
- Ou descomente a linha 5 no arquivo `docker-compose.yml` para construir e executar.

## Uso

```bash
docker container run -td --name nessus-scanner -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus-scanner:latest
```
Ou através do docker-compose: `docker-compose up -d`

- Acesse em: `https://localhost:8834`

# Suporte ao Podman

[Podman](https://podman.io/) é uma ferramenta de containers para desenvolvimento, gerenciamento e execução de containers como uma alternativa ao Docker.

## Construção

- Clone este repositório.
- Execute este comando: `podman build -t ciromota/nessus-scanner:latest -f .`

## Uso

```bash
podman run -td --name nessus -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus-scanner:latest
```
- Acesse em: `https://localhost:8834`

# Suporte ao DockerSlim

[DockerSlim](https://github.com/docker-slim/docker-slim) traz uma nova experiência em gerenciamento de container mantendo o mesmo workflow, produzindo um container menor e seguro.

Consulte a documentação e conheça todas as suas funções.

## Construção e Uso

Você pode executar o DockerSlim sobre a imagem criada anteriormente e reduzir o tamanho da imagem do scanner Nessus sem danos, basta usar o comando abaixo:

```bash
docker-slim build ciromota/nessus
```

Ou é possível, com a ajuda do próprio DockerSlim, construir uma nova imagem baseada no arquivo Dockerfile contido neste repo. Use o comando abaixo:

```bash
docker-slim build --dockerfile Dockerfile --show-blogs --tag ciromota/nessus.slim .
```

Em ambos os casos, você pode executar o container da mesma maneira:

```bash
docker container run -td --name nessus -p 8834:8834 -v \
/etc/localtime:/etc/localtime ciromota/nessus.slim
```
- Acesse em: `https://localhost:8834`

# Official Container

Tenable Nessus tem sua imagem de contêiner oficial 8.x.x em:

https://hub.docker.com/r/tenableofficial/nessus