FROM debian:stable-slim

LABEL maintainer="ciromota"
LABEL version="latest"

ADD https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/16503/download?i_agree_to_tenable_license_agreement=true /tmp/nessus.deb

RUN apt-get update -y \
	&& dpkg -i /tmp/*.deb \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/cache/apt/* \
	&& rm -f /tmp/*.deb

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]