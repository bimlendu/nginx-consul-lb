FROM amazon:2016.03
MAINTAINER Bimlendu Mishra

ARG NGINX_VERSION=1.8.1-1.26.amzn1
ARG CONSUL_TEMPLATE_VERSION=0.14.0

RUN yum install nginx-${NGINX_VERSION} unzip -y

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /tmp/

RUN unzip /tmp/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    chmod 755 /usr/local/bin/consul-template && \
    rm -v /etc/nginx/conf.d/*.conf

ADD nginx.conf.ctmpl /templates/nginx.conf.ctmpl
ADD vhosts.conf.ctmpl /templates/virtual.conf.ctmpl
ADD default.conf /etc/nginx/conf.d/default.conf

ADD start.sh /
RUN chmod u+x /start.sh

WORKDIR /

EXPOSE 80 443

CMD ["/start.sh"]
