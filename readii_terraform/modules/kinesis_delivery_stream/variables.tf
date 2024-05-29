variable "name" {
  description = "A name to identify the stream. This is unique to the AWS account and region the Stream is created in"
  type        = string
}


variable "destination" {
  description = "This is the destination to where the data is delivered"
  type        = string
}

variable "compression_format" {
  description = "The compression format. If no value is specified, the default is UNCOMPRESSED"
  type        = string
  default     = null
}

variable "prefix" {
  description = "You can specify an extra prefix to be added in front of the time format prefix"
  type        = string
  default     = null
}


variable "buffer_interval" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
}

variable "buffer_size" {
  description = " Buffer incoming data to the specified size, in MBs, before delivering it to the destination. The default value is 5"
  type        = number
}

variable "hec_endpoint" {
  description = "The HTTP Event Collector (HEC) endpoint to which Kinesis Firehose sends your data."
  type        = string
}

variable "hec_token" {
  description = "The GUID that you obtain from your Splunk cluster when you create a new HEC endpoint."
  type        = string
}

variable "hec_endpoint_type" {
  description = "The HEC endpoint type"
  type        = string
}

variable "s3_backup_mode" {
  description = "Defines how documents should be delivered to Amazon S3"
  type        = string
}

variable "hec_acknowledgment_timeout" {
  description = "The amount of time, in seconds between 180 and 600, that Kinesis Firehose waits to receive an acknowledgment from Splunk after it sends it data"
  type        = number
}

variable "role_arn" {
  description = "The ARN of the AWS credentials"
  type        = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket"
  type        = string
}

