variable "instance_type" {
  type = string
}

variable "environ" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "common_tags" {
  type = map(string)
  default = {
    Project    = "roboshop"
    Deployment = "terraform"
    Owner      = "Rakesh"
  }
}

variable "instances" {
  type    = list(string)
  default = ["mongodb"]
}

variable "ingress_rule" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_rule" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

