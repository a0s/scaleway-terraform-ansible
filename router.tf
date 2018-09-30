resource "scaleway_server" "router" {
  name = "router"
  image = "${data.scaleway_image.ubuntu-mini.id}"
  type = "START1-XS"
  enable_ipv6 = true
  dynamic_ip_required = true

  connection {
    type = "ssh"
    user = "root"
    private_key = "${file(var.scaleway_private_key_path)}"
    host = "${scaleway_server.router.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"root:root\" | chpasswd",
    ]
  }
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
