provider "scaleway" {
  organization = "${var.scaleway_organization}"
  token = "${var.scaleway_token}"
  region = "${var.scaleway_region}"
}

data "scaleway_image" "node_image" {
  architecture = "x86_64"
  name = "node-snapshot-mini"
  most_recent = true
}

data "scaleway_image" "router_image" {
  architecture = "x86_64"
  name = "node-snapshot-mini"
  most_recent = true
}
