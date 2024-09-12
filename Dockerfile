FROM debian:stable-slim as base
LABEL maintainer="ciromota"

ADD https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.8.3-debian10_amd64.deb /tmp/nessus.deb

RUN dpkg -i /tmp/*.deb

# hadolint ignore=DL3007
# hadolint ignore=DL3006
FROM cgr.dev/chainguard/wolfi-base as nessus-distroless

COPY --from=base /opt /opt

RUN apk add libgcc=14.2.0-r3 libstdc++=14.2.0-r3 --no-cache

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]
