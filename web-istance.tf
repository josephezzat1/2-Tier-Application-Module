resource "aws_instance" "web-instance" {
    ami="ami-0b029b1931b347543"
    instance_type="t2.micro"
    subnet_id =  aws_subnet.public_subnet["public_sub1"].id
    key_name = "joseph_KeyPair"
    tags = {
      "Name" = "Joseph-Web-Instance"
    }
}

resource "aws_security_group" "Web_Security_Groupe" {
  vpc_id = data.aws_vpc.vpc_data.id
  name = "Web_Security_Groupe"
  description = "Allowing HTTP and SSH to EC2 instance"

  ingress{
    to_port = 443
    from_port = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "allow_http_ssh"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.web-instance.id
  vpc      = true
}

terraform {
    backend "s3" {
    bucket = "joseph-bucket2"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}