output "vpc_id" {
    value = "${aws_vpc.fg-vpc.id}"
}

output "my_sub_id" {
    value = "${aws_subnet.fg-dev-subnet.id}"
}

output "my_sec_grp_id" {
    value = "${aws_security_group.fb-sg.id}"
}

output "my_igw_id" {
    value = "${aws_internet_gateway.fg_igw.id}"
  
}