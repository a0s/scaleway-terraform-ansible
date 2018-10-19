resource "scaleway_server" "router" {
  name = "router"
  image = "${data.scaleway_image.ubuntu-mini.id}"
  type = "START1-XS"
  enable_ipv6 = true
  dynamic_ip_required = true
  tags = ["router"]
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
      "echo \"${scaleway_server.router.id}\" >> /etc/hostid"
    ]
  }
}

resource "scaleway_security_group" "router" {
  name        = "router"
  description = "router protection"
}

resource "scaleway_security_group_rule" "proxy_allow_from_inner" {
  security_group = "${scaleway_security_group.router.id}"
  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 8888
}

resource "scaleway_security_group_rule" "proxy_deny_from_outer" {
  security_group = "${scaleway_security_group.router.id}"
  action    = "drop"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 8888
}

output "router_public_ip" {
  value = "${scaleway_server.router.public_ip}"
}

output "router_private_ip" {
  value = "${scaleway_server.router.private_ip}"
}

output "router_id" {
  value = "${scaleway_server.router.id}"
}
