output "ec2pubip" {
    value = aws_instance.web.public_ip
  
}