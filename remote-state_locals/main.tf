resource "aws_instance" "roboshop"{
    count = length(var.instances)
    region = var.region
    ami = data.aws_ami.roboshop.id
    instance_type = var.environ == "dev" ? var.instance_type : "t3.micro"
    vpc_security_group_ids = [aws_security_group.roboshop.id]
    tags = var.environ == "dev" ? merge({"Name": "${var.instances[count.index]}-dev"}, var.dev_common_tags) : merge({"Name": "${var.instances[count.index]}-prod"}, var.prod_common_tags)
}

resource "aws_security_group" "roboshop" {
    name = "roboshop-${var.environ}"
    description = "This security group is for roboshop project"
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
}
