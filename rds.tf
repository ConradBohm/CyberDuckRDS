resource "aws_db_instance" "aws_rds" {
    identifier = "cyberduck_rds"
    username = "root_user"
    manage_master_user_password = true
    multi_az = true

    engine = "mysql"
    engine_version = "8.1"
    instance_class = "db.t4g.large"
    allocated_storage = 50
    #maintenance_window = "mon:04:00-mon:04:30"

    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    storage_encrypted = true
    kms_key_id = aws_kms_key.rds_kms_key.arn

    skip_final_snapshot = true
}

resource "aws_db_instance" "aws_rds_replica" {
    replicate_source_db = aws_db_instance.aws_rds.identifier
    identifier = "cyberduck_rds_replica"
    username = "root_user"
    manage_master_user_password = true
    multi_az = true

    engine = "mysql"
    engine_version = "8.1"
    instance_class = "db.t4g.large"
    allocated_storage = 50
    #maintenance_window = "mon:04:00-mon:04:30"

    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    storage_encrypted = true
    kms_key_id = aws_kms_key.rds_kms_key.arn

    skip_final_snapshot = true
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "cyberduck_rds_subnet_group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}