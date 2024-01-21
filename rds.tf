resource "aws_db_instance" "cyberduck" {
    engine = "mysql
    instance_class = "db.t4g.large"
}