variable "common_tags" {
   type        = map(string)
   default     = {
        Environment = "Development"
        Owner       = "roboshop-cc"
        Deployment = "terraform"
        Project     = "Roboshop"
    }
}


variable "bucket_name" {
    description = "Name of the S3 bucket to create"
    default     = "myorg-terraform-state-file-roboshop88s"

    validation {
      condition = startswith(var.bucket_name, "myorg-")
      error_message = "Bucket name must start with 'myorg-'"
    }
}