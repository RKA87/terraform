resource "aws_instance" "roboshop"{
    ami = var.ami_id
    instance_type = var.environ == "dev" ? var.instance_type : "t3.micro"
    vpc_security_group_ids = [aws.security_group.roboshop]
}

resource "aws_security_group" "roboshop" {
    name = "roboshop-${var.environ}"
    description = "This security group is for roboshop project"
    ingress = [
        {
            from_port = 22
            to_port = 22
            cidr_blocks = ["0.0.0.0/0"]
            protocol = "tcp"
        }
    ]
}