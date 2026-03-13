resource "aws_instance" "test" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo dnf install git -y",
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      password    = "DevOps321"
      host        = self.private_ip
    }
  }
  tags = merge(var.common_tags, {
    Name = "TerraformProvisionedInstance"
  })
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.eggress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}


