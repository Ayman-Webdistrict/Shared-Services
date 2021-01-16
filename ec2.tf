resource "aws_key_pair" "squid_key" {
  key_name   = "squid_key"
  public_key = var.squid_key
}

data "template_file" "user_data" {
  template = "${file("files/userdata.sh")}"

  vars = {
    squid_user = "${var.squid_user}"
    squid_pass = "${var.squid_pass}"
  }
}

resource "aws_instance" "squid_proxy" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.ec2_type
  key_name = "squid_key"
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.squidproxy.id]
  user_data = data.template_file.user_data.rendered

  tags = {
    "Name" = "SquidProxy"
  }

  provisioner "file" {
    source      = "files/userdata.sh"
    destination = "/tmp/userdata.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host = self.public_ip
      private_key = file(var.ssh_priv_key)
    }
  }

  provisioner "file" {
    source      = "files/squid.conf"
    destination = "/tmp/squid.conf"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host = self.public_ip
      private_key = file(var.ssh_priv_key)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "/tmp/userdata.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host = self.public_ip
      private_key = file(var.ssh_priv_key)
    }
  }

}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}