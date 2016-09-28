#!/bin/bash
nginx &
/usr/local/bin/consul-template \
    -consul ${CONSUL_HOST}:${CONSUL_PORT} \
    -template="/templates/nginx.conf.ctmpl:/etc/nginx/nginx.conf:nginx -s reload" \
    -template="/templates/virtual.conf.ctmpl:/etc/nginx/conf.d/virtual.conf:nginx -s reload"
