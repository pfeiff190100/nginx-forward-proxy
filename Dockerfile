FROM alpine:latest
RUN apk add --no-cache --update openssl openssl-dev pcre pcre-dev zlib zlib-dev gcc libc-dev make patch

RUN adduser -D nginx
RUN wget http://nginx.org/download/nginx-1.23.4.tar.gz && \
 tar -xzvf nginx-1.23.4.tar.gz && \
 rm nginx-1.23.4.tar.gz

RUN wget https://github.com/chobits/ngx_http_proxy_connect_module/archive/refs/tags/v0.0.4.tar.gz && \
 tar -xzvf v0.0.4.tar.gz && \
 rm v0.0.4.tar.gz

RUN cd nginx-1.23.4 && \
 patch -p1 < ../ngx_http_proxy_connect_module-0.0.4/patch/proxy_connect_rewrite_102101.patch && \
 ./configure --add-module=../ngx_http_proxy_connect_module-0.0.4 --with-http_ssl_module && \
 make && make install

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj '/C=AT/ST=Styria/L=Weiz/O=HTL-Weiz/CN=localhost'
COPY ./config/nginx.conf /usr/local/nginx/conf/nginx.conf
EXPOSE 8080 8081

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
