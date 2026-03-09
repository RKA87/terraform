# Requirements for EC2 Instance is Security Group, AMI Name, Instance_Name

resource "aws_instance" "example_instance"{
    ami = "${var.ami_id}" #you can define variable like this also straight manner like below
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.example_sg.id]
    tags = var.ec2_tags
}

resource "aws_security_group" "example_sg"{
    name = var.sg_name
    description = var.sg_description
    dynamic "ingress" {
        for_each = var.ingress_rules
        content {
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
    dynamic "egress" {
        for_each = var.egress_rules
        content {
            from_port = egress.value.from_port
            to_port = egress.value.to_port
            protocol = egress.value.protocol
            cidr_blocks = egress.value.cidr_blocks
        }
    }    
    tags = merge(var.sg_tags, {
        AttachedInstanceName = var.ec2_tags["Name"]
    })
}