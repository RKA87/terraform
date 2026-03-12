variable "ami_id"{
    default = "ami-xjsjijsd"
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