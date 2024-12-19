resource "aws_docdb_cluster_parameter_group" "documentdb_param_group" {
  name        = "release-notes-publisher"
  family      = "docdb5.0" 
  description = "Cluster parameter group to disable TLS for DocumentDB"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}

resource "aws_docdb_cluster" "documentdb" {
  cluster_identifier      = "release-notes-db"
  engine                  = "docdb"
  master_username         = var.docdb_user
  master_password         = var.docdb_password
  backup_retention_period = 7
  skip_final_snapshot     = true
  port                    = var.docdb_port
  apply_immediately       = true
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.documentdb_param_group.name

  tags = {
    Name        = "release-notes-documentdb"
    Environment = "dev"
  }
}

resource "aws_docdb_cluster_instance" "documentdb_instance" {
  count              = 1
  identifier         = "release-notes-db-instance"
  cluster_identifier = aws_docdb_cluster.documentdb.id
  instance_class     = "db.t3.medium"
}