terraform {

backend "s3" {

bucket = "myterraformstatefilesbucket"
key = "terraform.tfstate"
region = "us-west-1"

}


}


provider "aws" {

region = "us-west-1"

}


resource "aws_instance" "appec2" {


ami = "ami-0cbd40f694b804622"
instance_type = "t2.micro"
tags = {

Name = "terraformec2server"
}

}


resource "aws_s3_bucket" "mys3bucket" {

bucket = "s3bucketfromterraform"

}

output "instance_id" {

description = "ID of EC2 instance"
value = "${aws_instance.appec2.id}"
}



output "instance_public_ip" {

description = "Public ip address of EC2 instance"
value = "${aws_instance.appec2.public_ip}"

}
