resource "aws_instance" "example" {
  count = length(var.instances)
  ami           = data.aws_ami.devopsredhat.id
  instance_type = local.instance_type
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ips.txt"
  }

  provisioner "local-exec" {
    command = "echo Destroying Instances"
    when    = destroy
  }

  provisioner "local-exec" {
    command = "echo > public_ips.txt"
    when    = destroy
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.instances[count.index]}-${local.environment}"
    }
  )
}

resource "aws_security_group" "sg" {
  name        = "terraform-demo-sg"
  description = "Allow SSH and HTTP traffic"

  dynamic "ingress" {
    for_each = var.ingress_rule
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.egress_rule
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}