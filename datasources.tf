provider "aws" {


region = "us-west-1"
}



data "aws_region" "current" {}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


data "aws_caller_identity" "current" {}

output "region_name" {

value = data.aws_region.current.name

}


output "region_description" {

value = data.aws_region.current.description

}


output "myaccid" {


value = data.aws_caller_identity.current.account_id
}


output "myarn" {


value = data.aws_caller_identity.current.arn
}



resource "aws_instance" "datasource" {


ami = data.aws_ami.ubuntu.id
instance_type = "t2.micro"

tags = {

Name = "DatasourceEC2"
region_desc = "${data.aws_region.current.description}"
account_id = "${data.aws_caller_identity.current.account_id}"


}

}
