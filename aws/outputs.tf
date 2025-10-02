output "instance_ip" {
value = aws_instance.example.public_ip
description = "Public IP of the EC2 instance"
}