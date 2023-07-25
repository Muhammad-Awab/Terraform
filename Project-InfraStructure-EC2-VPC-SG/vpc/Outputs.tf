output "vpc_id" {
  value = aws_vpc.project-vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}