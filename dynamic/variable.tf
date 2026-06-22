variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type"{
  description = "instance sizing"
  type = string
  default = "t3.micro"
}

variable "instances"{
  description = "deploy instances for roboshop"
  type = list(string)
  default = ["cart", "catalogue", "user", "frontend"]
}

variable "common_tags" {
  description = "Common tags to be used on all resources"
  type        = map(string)
  default = {
    owner     = "rakesh"
    terraform = "true"
    project   = "roboshop"
  }
}

variable "ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    cidr_blocks = list(string)
    protocol    = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    },
    {
      from_port   = 443
      to_port     = 443
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }
  ]
}

variable "egress_rules" {
  description = "Egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    cidr_blocks = list(string)
    protocol    = string
  }))
  default = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 1
    protocol    = "tcp"
    to_port     = 1
    }
  ]
}
