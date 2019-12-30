# Terraform
Docker image of terraform

## Supported tags and respective Dockerfile links

- `0.11.13-gitlab-runner-digitalocean`, `latest` [(0.11.13-gitlab-runner-digitalocean/Dockerfile)](https://github.com/mvochoa/terraform/blob/master/0.11.13-gitlab-runner-digitalocean/Dockerfile)

## Gitlab runner digitalocean
Create a droplet in DigitalOcean with gitlab-runner. The droplet for default has the following characteristics:

- **Image:** docker-18-04
- **Name:** $NAME_DROPLET
- **Region:** sfo2
- **Size:** s-1vcpu-3gb
- **User Data:** user_data.yml

The file `user_data.yml` its content is:

```yml
#cloud-config
runcmd:
  - sudo wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
  - sudo chmod +x /usr/local/bin/gitlab-runner
  - sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
  - sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
  - sudo gitlab-runner start
  - sudo gitlab-runner register -n --url $GITLAB_RUNNER_URL --tag-list "$GITLAB_RUNNER_TAGS" --registration-token $GITLAB_RUNNER_TOKEN --executor $GITLAB_RUNNER_EXECUTOR --description "$GITLAB_RUNNER_DESCRIPTION"
  - sudo usermod -aG docker gitlab-runner
```

### Environment Variables

#### `GITLAB_RUNNER_URL`

It is url for the runner register the default value is: `https://gitlab.com/`

#### `GITLAB_RUNNER_TAGS`

It is tags for the runner register the default value is: `runner`

#### `GITLAB_RUNNER_EXECUTOR`

It is executor for the runner register the default value is: `shell`

#### `GITLAB_RUNNER_DESCRIPTION`

It is description/name for the runner register the default value is: `Runner`

#### `TF_VAR_IMAGE_DROPLET`:

It is name of image for droplet of DigitalOcean for terraform the default value is: `docker-18-04`

#### `TF_VAR_REGION_DROPLET`:

It is region for droplet of DigitalOcean for terraform the default value is: `sfo2`

#### `TF_VAR_SIZE_DROPLET`:

It is size for droplet of DigitalOcean for terraform the default value is: `s-1vcpu-3gb`

#### `GITLAB_RUNNER_TOKEN`: Required

It is token for the runner register.

#### `TF_VAR_DO_TOKEN`: Required

It is token of DigitalOcean for terraform.

#### `TF_VAR_NAME_DROPLET`: Required

It is name for droplet of DigitalOcean for terraform.
