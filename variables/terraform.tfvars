# variables 
# first is command line and its syntax terraform -var="sg_name=example_sg_from_cmdline"
# second is terrafrom.tfvars file will take precedence over variables defined in variables.tf file
# thrid is terraform environment variables with syntax TF_VAR_sg_name=example_sg_from_env
# fourth is default value defined in variables.tf file will be used if no other value is provided

sg_name = "example_sg_from_tfvars"