FROM r-base
MAINTAINER hachepunto hachepunto@gmail.com

COPY ../*.R /

VOLUME ["/data"]

RUN apt-get update \
	&& apt-get install -y \
		9base \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& R < /install_dependencies.R

CMD ["/usr/bin/R"]
