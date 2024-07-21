resource "aws_instance" "fb-instances" {
  ami           = "${var.ami_size}"
  count = 3
  instance_type = "${var.instance_size}"
  vpc_security_group_ids = ["${var.sec_group_id}"]
  subnet_id     = "${var.sub_id}"
  tags = {
    Name = "${var.ec2_name}"
  }
}