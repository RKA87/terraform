output "instances_list" {
  description = "deployed instances list"
  value = {
    for each_instance in aws_instance.roboshop_deployment :
    each_instance.tags["Name"] => {
      id         = each_instance.id
      public_ip  = each_instance.public_ip
      private_ip = each_instance.private_ip
    }
  }
}