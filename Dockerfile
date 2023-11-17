FROM rockylinux:9.2

LABEL maintainer="ciromota"

ADD https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.6.3-es9.x86_64.rpm /tmp/nessus.rpm

RUN dnf upgrade -y \
	&& rpm -i /tmp/*.rpm \
	&& rm -rf /var/cache/dnf/* \
	&& rm -f /tmp/*.rpm

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]