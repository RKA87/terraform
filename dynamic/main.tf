resource "aws_instance" "roboshop_deployment" {
  for_each      = toset(var.instances)
  ami           = data.aws_ami.redhatdevops.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop-sg.id] 
  tags = merge(
    {
      Name        = each.key
      Environment = var.env
    }, var.common_tags
  )
}

resource "aws_security_group" "roboshop-sg"{
    description = "roboshop security group"
    name = "roboshop-sg"

    dynamic "ingress" {
        for_each = var.ingress_rules
        content {
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            cidr_blocks = ingress.value.cidr_blocks
            protocol = ingress.value.protocol         
        }  
    }
    dynamic "egress" {
        for_each = var.egress_rules
        content {
            from_port = egress.value.from_port
            to_port = egress.value.to_port
            cidr_blocks = egress.value.cidr_blocks
            protocol = egress.value.protocol         
        }  
    }
}