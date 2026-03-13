variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
  default     = "ami-0220d79f3f480ecf5"
}

variable "environ"{
    type = string
    default = "dev"
}

variable "common_tags"{
    type = map(string)
    default = {
        Environment = "dev"
        Owner       = "terraform"
        Deployment   = "terraform-provision"
    }
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
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }
    ]
}

variable "eggress_rules" {
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