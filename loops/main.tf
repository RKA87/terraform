resource "aws_instance" "robboshop" {
    count = length(var.instances)
    ami           = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.robboshop.id]
    tags = merge(var.environ == "dev" ? var.dev_common_tags : var.prod_common_tags, 
        {
        Name = "${var.instances[count.index]}-${var.environ}" #mongodb-dev, 
        })
}

resource "aws_security_group" "robboshop" {
    name        = "robboshop-sg"
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
    # tags = var.common_tags
}

resource "aws_lb_target_group" "roboshop" {
    name     = "roboshop-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    # tags = var.common_tags
    dynamic "health_check" {
        for_each = var.healthcheck == null ? [] : [var.healthcheck]
        content {
            healthy_threshold   = health_check.value.healthy_threshold
            unhealthy_threshold = health_check.value.unhealthy_threshold
            timeout             = health_check.value.timeout
            interval            = health_check.value.interval
            path                = health_check.value.path
            protocol            = health_check.value.protocol
            matcher             = "200-399"
        }
    }
}