# Get AMI Data
data "aws_ami" "devopsredhat" {
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
    name   = "owner-id"
    values = ["973714476881"]
  }
}
