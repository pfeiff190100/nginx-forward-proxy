FROM nginx:alpine

RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj '/C=AT/ST=Styria/L=Weiz/O=HTL-Weiz/CN=localhost'

COPY ./config/nginx.conf /etc/nginx/nginx.conf
