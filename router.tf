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
      "echo \"${file("keys/router.pub")}\" >> /root/.ssh/authorized_keys",
      "echo 1 > /proc/sys/net/ipv4/ip_forward",
      "iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o enp0s2 -j MASQUERADE"
    ]
  }
}
