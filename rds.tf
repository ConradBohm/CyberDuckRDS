resource "aws_db_instance" "aws_rds" {
    db_name = "cyberduck_rds"
    username = "default"
    manage_master_user_password = true
    multi_az = true

    engine = "mysql"
    instance_class = "db.t4g.large"
    allocated_storage = 50

    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name


    skip_final_snapshot = true
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "cyberduck_rds_subnet_group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}