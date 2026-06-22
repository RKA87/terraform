resource "aws_instance" "roboshop_deployment" {
  for_each               = toset(var.instances)
  ami                    = data.aws_ami.redhatlinux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  tags = merge(
    {
    Name      = each.key
    Component = each.key
    }, 
    local.common_tags
  )
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}