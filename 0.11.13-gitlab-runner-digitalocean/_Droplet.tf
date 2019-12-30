variable "DO_TOKEN" {}
variable "NAME_DROPLET" {}
variable "IMAGE_DROPLET" {}
variable "REGION_DROPLET" {}
variable "SIZE_DROPLET" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = "${var.DO_TOKEN}"
}

# Create droplet
resource "digitalocean_droplet" "runner" {
  image     = "${var.IMAGE_DROPLET}"
  name      = "${var.NAME_DROPLET}-1"
  region    = "${var.REGION_DROPLET}"
  size      = "${var.SIZE_DROPLET}"
  user_data = "${file("user_data.yml")}"
}