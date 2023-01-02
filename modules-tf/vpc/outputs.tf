output "pub_subnets" {
    value = aws_subnet.subnet_pub.*.id
  
}
output "security_group_ic" {
    value = aws_security_group.icsg.id
  
}