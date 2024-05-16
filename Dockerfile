FROM debian:stable-slim as base

LABEL maintainer="ciromota"

ADD https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.7.3-debian10_amd64.deb /tmp/nessus.deb

RUN apt-get update -y \
	&& apt-get install \
	lib32stdc++6 -y \
	&& dpkg -i /tmp/*.deb

FROM gcr.io/distroless/base-debian12 as nessus-distroless

COPY --from=base /opt /opt
COPY --from=base /usr/lib/x86_64-linux-gnu/libgcc_s.so.1 /usr/lib/x86_64-linux-gnu
COPY --from=base /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu

EXPOSE 8834

ENTRYPOINT [ "/opt/nessus/sbin/nessusd" ]
CMD ["start"]
