resource "scaleway_server" "node" {
  count = 2
  name = "node${count.index}"
  image = "${data.scaleway_image.ubuntu-mini.id}"
  type = "START1-XS"

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
      "echo \"${file("keys/router")}\" > /root/.ssh/router",
      "chmod 600 /root/.ssh/router",
      "cat /dev/zero | ssh-keygen -q -N \"\"",
      "echo \"${scaleway_server.router.private_ip} router\" >> /etc/hosts",

      "export DEFAULT_IP=$(ip route | awk '/^default/ { print $3 }')",
      "ip route del default",
      "ip route add 10.0.0.0/8 via $DEFAULT_IP",
      "ssh -f -i .ssh/router -w any router true",
      "ip route add default via 192.168.0.1"
    ]
  }
}
