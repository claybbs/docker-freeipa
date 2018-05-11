FROM centos:7

MAINTAINER Erik Osterman <e@osterman.com>

ENV NGINX_VERSION tengine-2.2.0


WORKDIR /usr/src/

ADD https://github.com/alibaba/tengine/archive/${NGINX_VERSION}.tar.gz tengine.tar.gz

# https://github.com/alibaba/tengine/blob/master/auto/options
# https://travis-ci.org/alibaba/tengine/jobs/32304924

RUN yum update -y && \
    yum install -y epel-release && \
    yum update -y && \
    yum install -y wget net-tools nc unzip gcc automake make openssl-devel zlib-devel&& \
    tar -zxvf tengine.tar.gz && \
    cd tengine-${NGINX_VERSION} && \
    ./configure \
            --prefix=/etc/nginx \
            --sbin-path=/usr/sbin/nginx \
            --conf-path=/etc/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log \
            --http-log-path=/var/log/nginx/access.log \
            --pid-path=/var/run/nginx.pid \
            --lock-path=/var/run/nginx.lock  &&\
    make && \
    make install && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/log/nginx"]
VOLUME ["/etc/nginx"]
VOLUME ["/var/cache/nginx"]

WORKDIR /etc/nginx

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

