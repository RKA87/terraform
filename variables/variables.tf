variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
    type = string
    default = "ami-0220d79f3f480ecf5"
}

variable "instance_type" {
    description = "The instance type for the EC2 instance"
    type = string
    default = "t3.micro"
}

variable "ec2_tags"{
    description = "Tags for the EC2 instance"
    type = map(string)
    default = {
        Name = "example_instance"
        Env = "dev"
        Project = "roboshop-example-instance"
        Deployment = "terraform"
    }
}

variable "sg_name" {
    description = "The name of the security group"
    type = string
    default = "example_sg"
}

variable "sg_description" {
    description = "The description of the security group"
    type = string
    default = "Security group for example instance"
}

# variable "sg_http_from_port" {
#     description = "The starting port for the HTTP security group rule"
#     type = number
#     default = 80
# }

# variable "sg_http_to_port" {
#     description = "The ending port for the HTTP security group rule"
#     type = number
#     default = 80
# }

# variable "sg_ssh_from_port" {
#     description = "The starting port for the SSH security group rule"
#     type = number
#     default = 22
# }

# variable "sg_ssh_to_port" {
#     description = "The ending port for the SSH security group rule"
#     type = number
#     default = 22
# }

# variable "cidr_blocks" {
#     description = "The CIDR blocks for the security group rules"
#     type = list(string)
#     default = ["0.0.0.0/0"]
# }

# variables defined for dynamic block in main.tf for security group rules

variable "ingress_rules" {
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = [
        {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            }
        ]
}

variable "egress_rules"{
    type = list (object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = [
        {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}

variable "sg_tags" {
    description = "Tags for the security group"
    type = map(string)
    default = {
        Name = "Example_SG"
        Env = "dev"
        Project = "roboshop-example-sg"
    }
}