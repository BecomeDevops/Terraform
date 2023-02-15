
provider "aws" {

  region = "ap-south-1"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "app_ec2" {
  ami           = "ami-01a4f99c4ac11b03c"
  instance_type = "t2.micro"
  user_data     = <<EOF
 #!/bin/bash
 yum -y update
 yum -y install httpd
 service httpd start
 chkconfig httpd on
 EOF

  tags = {
    Name = "app_ec2_terraform"
    Team = "Dev"
    Org  = "odlabs"
  }

}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow  inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {
    description = "ssh from ec2 port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "web_sg"

  }
}
