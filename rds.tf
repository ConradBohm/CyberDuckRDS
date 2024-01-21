resource "aws_db_instance" "aws_rds" {
    identifier = "cyberduck-rds"
    username = var.username
    password = var.password
    multi_az = true

    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t4g.large"
    allocated_storage = 50
    backup_retention_period = 7
    backup_window = "00:00-01:00"
    #maintenance_window = "mon:03:00-mon:04:30"

    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    storage_encrypted = true
    kms_key_id = aws_kms_key.rds_kms_key.arn

    skip_final_snapshot = true
}

resource "aws_db_instance" "aws_rds_replica" {
    replicate_source_db = aws_db_instance.aws_rds.identifier
    identifier = "cyberduck-rds-replica"
    multi_az = true

    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t4g.large"
    #backup_retention_period = 7
    #backup_window = "00:00-01:00"
    #maintenance_window = "mon:03:00-mon:04:30"

    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    #db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    storage_encrypted = true
    kms_key_id = aws_kms_key.rds_kms_key.arn

    skip_final_snapshot = true
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name = "cyberduck_rds_subnet_group"
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}

resource "aws_db_instance_automated_backups_replication" "main_instance_bacup" {
    source_db_instance_arn = aws_db_instance.aws_rds.arn
    kms_key_id = aws_kms_key.rds_kms_key.arn
    retention_period = 7
    provider = aws.replica
}