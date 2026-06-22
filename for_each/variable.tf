variable "sg"{
    description = "security group variable"
    type = list(string)
    default = ["sg-0e3e5d0160ba94b0b"]
}

variable "instance_type"{
    description = "instance sizing"
    type = string
    default = "t3.micro"
}

# variable "common_tags"{
#     description = "Commontags to use for roboshop deployment"
#     type = map(string)
#     default = {
#         project = "roboshop"
#         environment = locals.env
#         terraform = "true"
#         owner = "rakesh"
#     }    
# }

variable "instances" {
    description = "instances list to deploy for roboshop project"
    type = list(string)
    default = ["catalogue", "payment", "user", "cart", "shipping"]
}