resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.environ == "production" ? var.instance_type : "t3.large"
  security_groups = [aws_security_group.example.id]
  tags = var.common_tags
}

# create security group
resource "aws_security_group" "example" {
  name        = var.sg_name
  description = var.sg_description
  dynamic "ingress" {
    for_each = var.sg_ingress_rules 
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }   
  }
  dynamic "egress" {
    for_each = var.sg_egress_rules 
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }   
  }

  tags = merge(var.common_tags, 
  {
    Name = var.sg_name
    AttachedInstance=var.common_tags["Name"]
  })
}