
module "my-s3" {
  source = "/root/terraform/modules/s3"
  bucketname = "budhish-madana-sample-bucket"
  tags = {
    "ENV" = "DEV"
    "Depot" = "DevOps"
  }
}

module "network" {
    source = "/root/terraform/modules/vpc"
    vpc_cidr = "10.150.0.0/16"
    vpc_name = "acer-vpc"
    igw_name = "acer-igw"
    rt_name = "acer-rt"
    sub_cidr = "10.150.0.0/24"
    sec_groups = "acer-sec-grps"
    subnet_name = "acer-subnet"
}


module "fg-instance" {
    source = "/root/terraform/modules/ec2"
    count = 2
    ami_size = "ami-0b72821e2f351e396"
    instance_size = "t2.micro"
    key_pair = "terrakey"
    sec_group_id = "${module.network.my_sec_grp_id}"
    sub_id     = "${module.network.my_sub_id}"
}
