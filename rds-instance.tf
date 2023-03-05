resource "aws_db_instance" "RDS_instance"{

  allocated_storage    = 10
  db_name              = "JosephDB"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "joseph"
  password             = "joseph123456"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  multi_az = true

  port = 3306
  vpc_security_group_ids = [aws_security_group.DB_security_groupe.id]
} 

resource "aws_security_group" "DB_security_groupe" {
  name = "rds_sg"
  ingress {
    to_port =3306
    from_port = 3306 
    cidr_blocks  = ["10.0.3.0/24"]
    protocol = "tcp"
  }
}

resource "aws_db_subnet_group" "default" {

  name = "joseph_db_subnet_groupe"
  subnet_ids = [aws_subnet.private_subnet["private_sub1"].id, aws_subnet.private_subnet["private_sub2"].id]

  tags = {
    Name = "My DB subnet group"
  }
}