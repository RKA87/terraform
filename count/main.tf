resource "aws_instance" "roboshop_deployment" {
  count           = length(var.instances)
  ami             = data.aws_ami.redhatlinux.id
  instance_type   = var.instance_type
  vpc_security_group_ids = var.sg
  tags = merge(
    {
      Name = var.instances[count.index]
    }, var.common_tags
  )
}
