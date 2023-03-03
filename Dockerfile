FROM almalinux:9.1

LABEL maintainer="ciromota"

ADD https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.5.0-es9.aarch64.rpm /tmp/nessus.rpm

RUN dnf upgrade -y \
	&& rpm -i /tmp/*.rpm \
	&& rm -rf /var/cache/dnf/* \
	&& rm -f /tmp/*.rpm

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]