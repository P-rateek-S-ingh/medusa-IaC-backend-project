resource "aws_db_subnet_group" "medusa" {
  name       = "medusa-db-subnet-group"
  subnet_ids = module.vpc.public_subnets
}

resource "aws_db_instance" "medusa_db" {
  identifier           = "medusa-db"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  allocated_storage    = 20
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]
  db_name              = "medusa"
  db_subnet_group_name = aws_db_subnet_group.medusa.name
}
