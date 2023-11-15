provider "aws" {


  region = "us-west-1"

}




resource "aws_instance" "ec2server" {

  ami           = "ami-0cbd40f694b804622"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.websg.id]

  tags = {
Name = "ec2demo"

}

}


resource "aws_security_group" "websg" {
  name        = "sgrules"
  description = "my web security group"



  ingress {
    description = "opening port 80 for web access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }



  ingress {
    description = "opened port 22 for ssh access"
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

Name = "WebappSG"

}
}
