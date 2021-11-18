FROM debian:stable-slim

LABEL maintainer="ciromota"
LABEL version="latest"

ADD https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/15327/download?i_agree_to_tenable_license_agreement=true /tmp/nessus.deb

RUN apt-get update -y \
	&& apt-get install \
	iputils-ping \
	net-tools wget -y \
	&& dpkg -i /tmp/*.deb \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/cache/apt/* \	
	&& rm -f /tmp/*.deb

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]