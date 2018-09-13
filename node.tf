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
      "echo \"${file("keys/router")}}\" > /root/.ssh/router",
      "chmod 600 /root/.ssh/router",
      "cat /dev/zero | ssh-keygen -q -N \"\""
    ]
  }
}
