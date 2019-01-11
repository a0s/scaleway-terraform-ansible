provider "scaleway" {
  organization = "${var.scaleway_organization}"
  token = "${var.scaleway_token}"
  region = "${var.scaleway_region}"
}

data "scaleway_image" "ubuntu-mini" {
  architecture = "x86_64"
  name = "node-snapshot-mini"
  most_recent = true
}
