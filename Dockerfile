FROM debian:stable-slim AS base

ADD https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.9.3-debian10_amd64.deb /tmp/nessus.deb

RUN dpkg -i /tmp/*.deb

# hadolint ignore=DL3007
# hadolint ignore=DL3006
FROM cgr.dev/chainguard/wolfi-base AS nessus-distroless

LABEL org.opencontainers.image.title="Nessus Essentials Container"
LABEL org.opencontainers.image.description="Nessus Essentials Container with Distroless support."
LABEL org.opencontainers.image.authors="Ciro Mota <github.com/ciro-mota> (@ciro-mota)"
LABEL org.opencontainers.image.url="https://github.com/ciro-mota/nessus-scanner"
LABEL org.opencontainers.image.documentation="https://github.com/ciro-mota/nessus-scanner#README.md"
LABEL org.opencontainers.image.source="https://github.com/ciro-mota/nessus-scanner"

COPY --from=base /opt /opt

RUN apk add libgcc=15.1.0-r3 libstdc++=15.1.0-r3 --no-cache

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]
