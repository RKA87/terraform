resource "aws_instance" "app" {
  count = length(var.instances)
  region = local.region
  ami                   = data.aws_ami.devopsredhat.id
  instance_type         = var.instance_type
  vpc_security_group_ids= [aws_security_group.sg.id]

  tags                  = merge(local.tags, 
    { 
        Name = "${var.instances[count.index]}-${var.environ}" 
    }
  )
}

resource "aws_security_group" "sg" {
  name        = "${var.environ}-app-sg"
  description = "Security group for ${var.environ} environment"

  dynamic "ingress" {
    for_each = local.ingress_rule
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = local.egress_rule
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(local.tags, 
    { 
        Name = "${var.environ}-app-sg" 
    }
  )
}   