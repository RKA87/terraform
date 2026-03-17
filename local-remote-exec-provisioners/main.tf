# Important Note: Provisioners should be used as a last resort.

# local-exec is useful for running commands on the machine where Terraform is being executed. 
# It can be used for tasks like generating files, running scripts, or performing local operations that are necessary for the infrastructure setup.

# remote-exec is used to run commands on the remote resource (like an EC2 instance) after it has been created. 
# It is typically used for configuration management tasks, such as installing software, configuring services, or 
# performing any setup that needs to happen on the instance itself.

resource "aws_instance" "example" {
  count                  = length(var.instances)
  ami                    = data.aws_ami.devopsredhat.id
  instance_type          = local.instance_type
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ips.txt"
  }

  # provisioner "local-exec" {
  #   command = "bash bootstrap.sh"
  # }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = "DevOps321"
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y"
    ]
  }

  provisioner "local-exec" {
    command = "echo > public_ips.txt"
    when    = destroy
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.instances[count.index]}-${local.environment}"
    }
  )
}

resource "aws_security_group" "sg" {
  name        = "terraform-demo-sg"
  description = "Allow SSH and HTTP traffic"

  dynamic "ingress" {
    for_each = var.ingress_rule
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.egress_rule
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}