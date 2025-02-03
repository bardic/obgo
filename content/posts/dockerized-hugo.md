+++
date = '2025-02-02T17:10:59-04:00'
draft = false
title = 'Dockerized Hugo'
+++

Currently I manage all my hosted services with docker and to maintain consistentency I decided to server my Hugo blog (this site) through docker as well. 

Here is the current Dockerfile I use for building and servering. Very simple. 

```yaml
FROM alpine:latest AS Builder
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo
WORKDIR /openbracket
COPY . . 
RUN hugo

FROM python:alpine3.21 AS Runner
COPY --from=Builder /openbracket/public/ /www
WORKDIR /www
EXPOSE 8989
CMD ["python", "-m", "http.server", "8989"] 
```