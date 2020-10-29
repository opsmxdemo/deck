FROM registry.access.redhat.com/ubi8/ubi
MAINTAINER sig-platform@spinnaker.io
LABEL name='deck'
LABEL maintainer='info@opsmx.io'
LABEL release=2
LABEL version='1.21.1'
LABEL summary='Red Hat certified Open Enterprise Spinnaker ubi8 container image for deck'
LABEL description='Certified Open Enterprise Spinnaker is an Enterprise grade, Red Hat certified and OpsMx supported release of the popular and critically acclaimed Continuous Delivery platform Spinnaker'
LABEL vendor='OpsMx'

WORKDIR /opt/deck
COPY docker        /opt/deck/docker
COPY docker/runapache2.sh docker/run-apache2.sh
COPY docker/setupapache2.sh docker/setup-apache2.sh

RUN chmod -R 777 docker/setup-apache2.sh
RUN docker/setup-apache2.sh

COPY build/webpack /opt/deck/html
RUN chown -R apache:apache /opt/deck
USER apache

CMD docker/run-apache2.sh
