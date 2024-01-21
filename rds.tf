resource "aws_db_instance" "aws_rds" {
    db_name = "cyberduck_rds"
    username = "default"
    manage_master_user_password = true
    multi_az = true

    engine = "mysql"
    instance_class = "db.t4g.large"
    allocated_storage = 50

    skip_final_snapshot = true
}