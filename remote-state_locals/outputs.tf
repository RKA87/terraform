output "instance_ids" {
    value = aws_instance.roboshop.*.id
}

output "instance_private_ips" {
    value = aws_instance.roboshop.*.private_ip
}

output "multiple_output_attributes" {
  value = {
    for index, instance in aws_instance.roboshop : index => {
      id         = instance.id
      private_ip = instance.private_ip
      public_ip  = instance.public_ip
    }
  }
}