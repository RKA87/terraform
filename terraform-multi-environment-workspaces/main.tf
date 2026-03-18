# Build a instance
resource "aws_instance" "roboshop"{
    count = length(var.instances)
    ami = local.ami_id
    instance_type = local.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = merge(local.tags, 
        {
            Name = "${var.instances[count.index]}-${local.environment}"
        },
        {
            Environment = "${local.environment}"
        }
    )
}

resource "aws_security_group" "sg"{
    name = "roboshop-project-${local.environment}"
    description = "Roboshop Project Ports Access"
    dynamic "ingress" {
        for_each = local.ingress_rule
        content {
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
    dynamic "egress"{
        for_each = local.egress_rule
        content {
            from_port = egress.value.from_port
            to_port = egress.value.to_port
            protocol = egress.value.protocol
            cidr_blocks = egress.value.cidr_blocks
        }
    }
    tags = local.tags       
}