FROM golang:alpine AS builder

ENV TERRAFORM_VERSION=0.14.4

RUN apk add --update git bash openssh

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

FROM alpine:3.8
LABEL maintainer="mario@mvochoa.com"

RUN apk add --update --no-cache gettext openssh curl git coreutils bash jq wget \
    && wget https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_386 -O /usr/bin/yq && chmod +x /usr/bin/yq

WORKDIR /tf

COPY --from=builder /go/bin/terraform /usr/local/bin/terraform
CMD ["tail", "-f", "/dev/null"]
