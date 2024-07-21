resource "aws_vpc" "fg-vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name = "${var.vpc_name}"
  }
}
resource "aws_internet_gateway" "fg_igw" {
  vpc_id = "${aws_vpc.fg-vpc.id}"

  tags = {
    Name = "${var.igw_name}"
  }
}
resource "aws_route_table" "fg-rt" {
  vpc_id = "${aws_vpc.fg-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.fg_igw.id}"
  }
  tags = {
    Name = "${var.rt_name}"
  }
}
resource "aws_subnet" "fg-dev-subnet" {
  vpc_id     = "${aws_vpc.fg-vpc.id}"
  cidr_block = "${var.sub_cidr}"

  tags = {
    Name = "${var.subnet_name}"
  }
}
resource "aws_route_table_association" "subassociation" {
  subnet_id      = "${aws_subnet.fg-dev-subnet.id}"
  route_table_id = "${aws_route_table.fg-rt.id}"
}

resource "aws_security_group" "fb-sg" {
  name        = "${var.sec_groups}"
  description = "Allow HTTP, HTTPS, and SSH inbound traffic and all outbound traffic"
  vpc_id      = "${aws_vpc.fg-vpc.id}"
  tags = {
    Name = "${var.sec_groups}"
  }
}

resource "aws_security_group_rule" "inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.fg-vpc.cidr_block]
  security_group_id = aws_security_group.fb-sg.id
}

resource "aws_security_group_rule" "inbound_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.fg-vpc.cidr_block]
  security_group_id = "${aws_security_group.fb-sg.id}"
}

resource "aws_security_group_rule" "inbound_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.fg-vpc.cidr_block]
  security_group_id = "${aws_security_group.fb-sg.id}"
}

resource "aws_security_group_rule" "allow_all_traffic_ipv4" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"  # semantically equivalent to all ports
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fb-sg.id}"
}