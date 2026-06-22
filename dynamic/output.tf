output "instances_list" {
  description = "deployed instances list"
  value = {
    for instance in aws_instance.roboshop_deployment :
    instance.tags["Name"] => {
      id         = instance.id
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
}