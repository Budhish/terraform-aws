variable "vpc-cidr" {}
variable "vpc-name" {}
variable "igw-name" {}
variable "fg-rt-name" {}
variable "sub-cidr" {}
variable "fg-sec-groups" {}
variable "subnet-name" {}
variable "ami_size" {}
variable "instance_size" {}
variable "key_pair" {}
variable "server-names" {
  type = list(string)
  default = ["dev-server1", "dev-server2", "dev-server3" ]
}

