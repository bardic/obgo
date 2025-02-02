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