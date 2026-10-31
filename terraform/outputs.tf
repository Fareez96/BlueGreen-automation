output "public_ip" {
  value = aws_instance.server.public_ip
}

output "ssh_command" {
  value = "ssh -i ${local_file.private_key.filename} ubuntu@${aws_instance.server.public_ip}"
}
