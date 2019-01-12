resource "scaleway_server" "router" {
  name = "router"
  image = "${data.scaleway_image.router_image.id}"
  type = "START1-XS"
  enable_ipv6 = true
  dynamic_ip_required = true
  tags = [
    "router"]
  security_group = "${scaleway_security_group.router.id}"

  connection {
    type = "ssh"
    user = "root"
    private_key = "${file(var.scaleway_private_key_path)}"
    host = "${scaleway_server.router.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"root:root\" | chpasswd",
      "echo \"${scaleway_server.router.id}\" > /etc/host_id",
      "echo \"0\" > /etc/host_number",
      "netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v \"0.0.0.0\" > /etc/host_gateway"
    ]
  }
}

resource "scaleway_security_group" "router" {
  name = "router"
  description = "router protection"
}
