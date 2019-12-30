FROM golang:alpine AS builder

ENV TERRAFORM_VERSION=0.12.16

RUN apk add --update git bash openssh

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

FROM alpine:3.8

RUN apk add --update --no-cache gettext openssh curl git coreutils bash jq

WORKDIR /tf

COPY --from=builder /go/bin/terraform /usr/local/bin/terraform
CMD ["tail", "-f", "/dev/null"]