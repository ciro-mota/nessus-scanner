FROM almalinux:latest

LABEL maintainer="ciromota"

ADD https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/16876/download?i_agree_to_tenable_license_agreement=true /tmp/nessus.rpm

RUN dnf upgrade -y \
	&& rpm -i /tmp/*.rpm \
	&& rm -rf /var/cache/dnf/* \
	&& rm -f /tmp/*.rpm

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]