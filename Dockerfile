FROM debian:stable-slim

LABEL maintainer="ciromota"
LABEL version="latest"

RUN apt update -y \
	&& apt install iputils-ping \
	net-tools wget -y
	
RUN rm -rf /var/lib/apt/lists/*

RUN wget -qc https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/12098/download?i_agree_to_tenable_license_agreement=true -O /tmp/nessus.deb

RUN dpkg -i /tmp/nessus.deb	

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]