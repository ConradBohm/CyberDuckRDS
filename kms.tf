resource "aws_kms_key" "rds_kms_key" {
  description = "KMS Key for RDS Encryption"
  deletion_window_in_days = 30
}