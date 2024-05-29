output "firehose_delivery_stream_name" {
  description = "The name of the firehose_delivery_stream_name."
  value       = aws_kinesis_firehose_delivery_stream.this.name
}

output "firehose_delivery_stream_arn" {
  description = "The ARN of the firehose_delivery_stream_arn."
  value       = aws_kinesis_firehose_delivery_stream.this.arn
}
