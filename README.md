# nginx-forward-proxy

## Setup of container

build and compose the docker file
```
docker build -t nginx_forward .
docker compose up
```

copy certificate to local maschine so the browser can trust it

```
docker cp forward_proxy:/etc/ssl/certs/nginx.crt /path/to/local/directory
```