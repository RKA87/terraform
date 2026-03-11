variable "instance_type" {
  description = "The type of instance to use"
  default     = "t2.micro"
}

variable "common_tags" {
   type        = map(string)
   default     = {
        Environment = "Development"
        Owner       = "roboshop-cc"
        Deployment = "terraform"
        Project     = "Roboshop"
    }
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
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

variable "egress_rules"{
    description = "List of egress rules for the security group"
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

variable "instances" {
    type = list(string)
    default = ["mongodb", "redis", "mysql", "catalogue", "user", "cart", "shipping", "payment", "dispatch", "frontend"]
}
