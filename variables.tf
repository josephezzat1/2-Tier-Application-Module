variable "name" {}

variable "vpc_id" {}

data "aws_vpc" "vpc_data"{
    id = var.vpc_id
}

variable "private-subnet" {
  type = map
  default = {
    private_sub1 ={
        availability_zone = "us-west-2a"
        cidr = "10.0.4.0/24"
    }
      private_sub2 ={
        availability_zone = "us-west-2b"
        cidr = "10.0.5.0/24"
    }
  }
}

variable "public-subnet" {
  type = map 
  default = {
    public_sub1 ={
        availability_zone = "us-west-2a"
        cidr = "10.0.6.0/24"
    }
  }
}