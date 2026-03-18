locals{
    environment = terraform.workspace
    ami_id = data.aws_ami.devopsredhat.id
    instance_type = var.instance_type
    region = var.region
    # env = var.environ
    tags = var.common_tags
    ingress_rule = var.ingress_rule
    egress_rule = var.egress_rule
    }