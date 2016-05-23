FROM alpine:edge

ENV VERSION 0.6.16

RUN apk update && \
    apk add ca-certificates curl \
    unzip \
    wget && \
    wget -q -O /terraform.zip https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip && \
    unzip /terraform.zip -d /bin && \
    apk del --purge wget unzip && \
    rm -rf /var/cache/apk/* /terraform.zip

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
