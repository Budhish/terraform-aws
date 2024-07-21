resource "aws_instance" "fb-instances" {
  ami           = "${var.ami_size}"
  instance_type = "${var.instance_size}"
  #vpc_security_group_ids = ["${aws_security_group.fb-sg.id}"]
  #subnet_id     = "${aws_subnet.fg-dev-subnet.id}"
  vpc_security_group_ids = ["${var.sec_id}"]
  subnet_id     = "${var.sub_id}"
  key_name = "${var.key_pair}"
  tags = {
    "ENV" = "Dev"
    "Name" = "${element(var.server-names, count.index)}"
  }
}