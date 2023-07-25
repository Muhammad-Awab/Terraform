variable "ami_id" {
  default = "ami-053b0d53c279acc90"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "security_group_id" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "public_subnet_id" {
  type = string
}
variable "private_subnet_id" {
  type = string
}
