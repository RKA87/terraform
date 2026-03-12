variable "region" {
    type = string
    default = "us-east-1"
}

variable "instance_type"{
    type = string
    default = "t2.micro"
}

variable "environ"{
    type = string
    default = "dev"
}

variable "dev_common_tags"{
    type = map(string)
    default = {
        Project = "roboshop"
        Deployment = "Terraform"
        Environment = "Development"

    }
}

variable "prod_common_tags"{
    type = map(string)
    default = {
        Project = "roboshop"
        Deployment = "Terraform"
        Environment = "Production"
    }
}


variable "instances" {
    type = list(string)
    default = ["mongodb", "redis", "mysql", "catalogue", "user", "cart", "shipping", "payment", "dispatch", "frontend"]
}


variable "ingress_rules" {
    type = list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
    default = [
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}

variable "egress_rules" {
    type = list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
    default = [
        {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}