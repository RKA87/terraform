output "instances_output" {
  value = aws_instance.robboshop[*].id
}