/*================
AWS Variables
=================*/

variable "aws_vpc_cidr" {}
variable "aws_vpc_name" {}
variable "aws_subnet_name_2a" {}
variable "aws_subnet_name_2b" {}
variable "aws_subnet_name_2c" {}
variable "aws_subnet_name_2d" {}
variable "aws_subnet_cidr_2a" {}
variable "aws_subnet_cidr_2b" {}
variable "aws_subnet_cidr_2c" {}
variable "aws_subnet_cidr_2d" {}

/*================
AWS VPC
=================*/

resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc_cidr

  tags = {
    Name = var.aws_vpc_name
  }
}

/*================
Create AWS Subnets
=================*/

resource "aws_subnet" "mca-subnet-demo-2a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_cidr_2a
  availability_zone = "us-west-2a"

  tags = {
    Name = var.aws_subnet_name_2a
  }
}

resource "aws_subnet" "mca-subnet-demo-2b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_cidr_2b
  availability_zone = "us-west-2b"

  tags = {
    Name = var.aws_subnet_name_2b
  }
}

resource "aws_subnet" "mca-subnet-demo-2c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_cidr_2c
  availability_zone = "us-west-2c"

  tags = {
    Name = var.aws_subnet_name_2c
  }
}

resource "aws_subnet" "mca-subnet-demo-2d" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_cidr_2d
  availability_zone = "us-west-2d"

  tags = {
    Name = var.aws_subnet_name_2d
  }
}

/*================
Outputs variables for other modules to use
=================*/

output "connected_vpc" {value = aws_vpc.vpc}
output "connected_vpc_subnet_1" {value = aws_subnet.mca-subnet-demo-2a}
output "connected_vpc_subnet_2" {value = aws_subnet.mca-subnet-demo-2b}
output "connected_vpc_subnet_3" {value = aws_subnet.mca-subnet-demo-2c}
output "connected_vpc_subnet_4" {value = aws_subnet.mca-subnet-demo-2d}
