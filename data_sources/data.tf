data "aws_ami" "latest" {
    most_recent = true
    
    filter {
        name   = "name"
        values = ["Redhat-9-DevOps-Practice"]
    }
    
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    
    filter {
        name = "owner-id"
        values = ["973714476881"]
    } 
}

data "aws_instance" "info" { #we need to use aws_instance for single instance to get the details, we can use aws_instances for multiple instances
    instance_id = "i-i-0971a1b7bbbef9f9a"
}
