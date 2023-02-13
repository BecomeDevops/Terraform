provider "aws" {
  region = "ap-south-1"
}


resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}








resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myigw"
  }
}


resource "aws_subnet" "pubsub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "mypubsub1"
    Team = "Devops"
  }
}





resource "aws_subnet" "prisub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "myprisub1"
    Team = "Devops"
  }
}




resource "aws_route_table" "mypubrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "pubrtassoc" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.mypubrt.id
}


resource "aws_eip" "myeip" {

}

resource "aws_nat_gateway" "mynatgw" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.prisub1.id

  tags = {
    Name = "mynatgw"


}


}
