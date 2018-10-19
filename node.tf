resource "scaleway_server" "node" {
  count = 3
  name = "node${count.index}"
  image = "${data.scaleway_image.ubuntu-mini.id}"
  type = "START1-XS"
  tags = ["node"]

  connection {
    type = "ssh"
    user = "root"
    private_key = "${file(var.scaleway_private_key_path)}"
    host = "${self.private_ip}"
    bastion_host = "${scaleway_server.router.public_ip}"
    bastion_user = "root"
    bastion_private_key = "${file(var.scaleway_private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"root:root\" | chpasswd",
      "echo \"${scaleway_server.router.private_ip} router\" >> /etc/hosts",
    ]
  }
}

output "node_public_ip" {
  value = "${scaleway_server.node.*.public_ip}"
}

output "node_private_ip" {
  value = "${scaleway_server.node.*.private_ip}"
}

output "node_id" {
  value = "${scaleway_server.node.*.id}"
}
