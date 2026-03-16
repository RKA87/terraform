resource "aws_instance" "example" {
  count = length(var.instances)
  ami           = data.aws_ami.devopsredhat.id
  instance_type = local.instance_type
  region = local.region
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  provisioner "local-exec" {
    command = "echo ${aws_instance.example[count.index].public_ip} > public_ips.txt"
  }
  tags = merge(
    local.tags,
    {
      Name = "${var.instances[count.index]}-${local.environment}"
    }
  )
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

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
