provider "scaleway" {
  organization = "${var.scaleway_organization}"
  token = "${var.scaleway_token}"
  region = "${var.scaleway_region}"
}

data "scaleway_image" "ubuntu-mini" {
  architecture = "x86_64"
  name = "Ubuntu Mini Xenial 25G"
}

data "scaleway_image" "ubuntu" {
  architecture = "x86_64"
  name = "Ubuntu Xenial"
}
