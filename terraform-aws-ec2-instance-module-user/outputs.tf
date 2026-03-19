output "instance_ids" {
  value = aws_instance.app[*].id
}

output "multiple_output_attributes" {
    value = {
        for index, instance in aws_instance.app : index => {
            id         = instance.id
            private_ip = instance.private_ip
            public_ip  = instance.public_ip
        }
    }
  
}