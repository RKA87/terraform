output "instances_details" {
  description = "Instances Details"
  value = {
    for instance in aws_instance.roboshop_deployment :
    instance.tags["Name"] => {
      instance_id = instance.id
      public_ip   = instance.public_ip
      private_ip  = instance.private_ip
    }
  }
}
