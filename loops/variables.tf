variable "ami_id" {
  description = "The ID of the AMI to use for the instance."
  type        = string
  default     = "ami-0220d79f3f480ecf5"
}

variable "instance_type" {
  description = "The type of instance to create."
  type        = string
  default     = "t2.micro"
}

variable "environ"{
  type = string
  default = "dev"
}

variable "dev_common_tags" {
  description = "Common tags for all resources."
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "roboshop"
    Deployment = "terraform"
  }
}

variable "prod_common_tags" {
  description = "Common tags for all resources."
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "roboshop"
    Deployment = "terraform"
  }
}

variable "instances"{
    type = list(string)
    default = ["mongodb", "redis", "mysql", "catalogue", "cart", "user", "shipping", "payment", "rabbitmq", "frontend", "dispatch"]
}

variable "ingress_rules"{
    type = list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
    default = [
        {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}

variable "egress_rules"{
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

variable "vpc_id" {
  description = "The ID of the VPC where resources will be created."
  type        = string
  default     = "vpc-0a1e8f6f70460777f"
}


# Health check configuration for TG is loaded with one set of values without multiple blocks as list and it can be overriden
variable "healthcheck" {
  description = "Health check configuration for the instances."
  type = object({
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
    path                = string
    protocol            = string
  })
  default = {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    path                = "/health"
    protocol            = "HTTP"
  }
}