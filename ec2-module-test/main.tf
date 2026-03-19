module "ec2_build" {
  source        = "../terraform-aws-ec2-instance-module-user"
  instance_type = "t2.micro"
  environ       = "dev"
  instances     = ["mongodb", "mysql"]
}