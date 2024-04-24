resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.name
  destination = var.destination

  s3_configuration {
    role_arn           = var.role_arn
    bucket_arn         = var.bucket_arn
    buffer_size        = var.buffer_size
    buffer_interval    = var.buffer_interval
    compression_format = var.compression_format
    prefix = var.prefix
  }

  splunk_configuration {
    hec_endpoint               = var.hec_endpoint
    hec_token                  = var.hec_token
    hec_acknowledgment_timeout = var.hec_acknowledgment_timeout
    hec_endpoint_type          = var.hec_endpoint_type
    s3_backup_mode             = var.s3_backup_mode
  }
}