resource "aws_db_subnet_group" "main" {
  name       = "main-${var.environment}"
  subnet_ids = var.private_subnets

  tags = {
    Name = "DB Subnet Group"
  }
}

resource "aws_security_group" "rds" {
  name        = "rds-sg-${var.environment}"
  description = "Allow inbound traffic to Aurora"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Restrict to VPC CIDR
  }
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "fullstack-db-${var.environment}"
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned"
  engine_version          = "15.3"
  database_name           = "appdb"
  master_username         = "admin_user"
  manage_master_user_password = true
  kms_key_id              = var.kms_key_arn
  storage_encrypted       = true
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = var.environment == "prod" ? false : true

  serverlessv2_scaling_configuration {
    max_capacity = 16.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "instance_1" {
  identifier         = "fullstack-db-instance-1"
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.postgresql.engine
  engine_version     = aws_rds_cluster.postgresql.engine_version
}