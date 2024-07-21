resource "aws_s3_bucket" "fg-s3" {
  bucket = "${var.bucketname}"

  tags = "${var.tags}"
}
