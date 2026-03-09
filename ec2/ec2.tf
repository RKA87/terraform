# Requirements for EC2 Instance is Security Group, AMI Name, Instance_Name

resource "aws_instance" "example_instance"{
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.example_sg.id]
    tags = {
        Name = "example_instance"
        Env = "dev"
        Project = "roboshop-example-instance"
    }

}

resource "aws_security_group" "example_sg"{
    name = "example_sg"
    description = "Security group for example instance"
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Example_SG"
        Env = "dev"
        Project = "roboshop-example-sg"
    }
}