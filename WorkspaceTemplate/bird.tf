
resource "null_resource" "bird" {

    count = "${var.instance_count}"

    connection {
        type = "ssh"
        host = "${element(packet_device.hosts.*.access_public_ipv4,count.index)}"
        private_key = "${file("mykey")}"
        agent = false
    }

    provisioner "remote-exec" {
        inline = [
            "apt-get -y install bird > apt-get-bird-out.txt",
            "sysctl net.ipv4.ip_forward=1",
            "sysctl net.ipv6.conf.all.forwarding=1",
        ]
    }
}


