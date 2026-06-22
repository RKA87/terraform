variable "instance_type" {
  type = string
  description = "instance sizing"
  default = "t3.micro"
}

variable "common_tags" {
    type = map(string)
    description = "common tags to use for deployment"
    default = {
        env = "dev"
        project = "roboshop"
        deployment = "terraform"
        owner = "rakesh"
    }
}

variable "sg"{
    type = list(string)
    description = "security group id"
    default = ["sg-0e3e5d0160ba94b0b"]
}

variable "instances"{
    type = list(string)
    description = "instances list to deploy"
    default = ["catalogue","user","cart","shipping","payment"]
}