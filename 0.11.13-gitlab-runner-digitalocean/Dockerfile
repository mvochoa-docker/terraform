FROM golang:alpine AS builder

ENV TERRAFORM_VERSION=0.11.13

RUN apk add --update git bash openssh

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

FROM alpine:3.8

ENV GITLAB_RUNNER_URL=https://gitlab.com/
ENV GITLAB_RUNNER_TAGS=runner
ENV GITLAB_RUNNER_EXECUTOR=shell
ENV GITLAB_RUNNER_DESCRIPTION=Runner
ENV TF_VAR_IMAGE_DROPLET=docker-18-04
ENV TF_VAR_REGION_DROPLET=sfo2
ENV TF_VAR_SIZE_DROPLET=s-1vcpu-3gb

RUN apk add --update --no-cache gettext openssh curl

WORKDIR /tf
COPY _Droplet.tf ./
COPY user_data.yml ./

COPY --from=builder /go/bin/terraform /usr/local/bin/terraform
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN terraform init

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]