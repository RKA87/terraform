variable "ami_id" {
  description = "The ID of the AMI to use for the instance."
  type        = string
  default = "ami-0220d79f3f480ecf5"
}

# Conditions
variable "environ"{
    type        = string
    default     = "dev"
}

variable "instance_type" {
  description = "The type of instance to create."
  type        = string
  default     = "t3.micro"
}

variable "common_tags" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
  default     = {
        Name = "example_instance"
        Env = "dev"
        Project = "roboshop-example-instance"
        Deployment = "terraform"
  }
}

variable "sg_name" {
  type        = string
  default     = "example-sg"
}

variable "sg_description" {
  type        = string
  default     = "Example security group"
}

variable "sg_ingress_rules" {
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

variable "sg_egress_rules" {
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
