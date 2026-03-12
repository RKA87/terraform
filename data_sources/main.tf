resource "aws_instance" "roboshop" {
    count        = length(var.instances)
    ami           = data.aws_ami.latest.id
    vpc_security_group_ids = [aws_security_group.roboshop.id]
    instance_type = var.instance_type
    
    tags = merge(var.common_tags, {
            Name = "roboshop"
        })
}

resource "aws_security_group" "roboshop" {
  name        = "roboshop-sg"
  description = "Security group for Roboshop instances"
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
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
  tags = merge(var.common_tags, {
            Name = "roboshop-sg"
        })
}