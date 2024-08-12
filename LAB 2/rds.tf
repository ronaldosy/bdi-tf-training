resource "random_password" "db_password" {
  length           = 12
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]
}

resource "aws_db_instance" "pgsql_db" {
  identifier              = "training-db"
  instance_class          = var.rds_instance_type
  allocated_storage       = 10
  engine                  = "postgres"
  engine_version          = "15.5"
  username                = "demoadmin"
  password                = random_password.db_password.result
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allow_to_pg_rds.id]
  parameter_group_name    = "default.postgres15"
  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7
}