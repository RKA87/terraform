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
    ingress{
        from_port = var.sg_http_from_port
        to_port = var.sg_http_to_port
        protocol = "tcp"
        cidr_blocks = var.cidr_blocks
    }
    ingress{
        from_port = var.sg_ssh_from_port
        to_port = var.sg_ssh_to_port
        protocol = "tcp"
        cidr_blocks = var.cidr_blocks
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.cidr_blocks
    }
    tags = merge(var.sg_tags, {
        AttachedInstanceName = var.ec2_tags["Name"]
    })
}