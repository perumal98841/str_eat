variable "enabled" {
  type        = bool
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = true
}

variable "name_prefix" {
  type        = string
  description = "Name prefix used to create resources."
}


variable "scope" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL. To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider."
  default     = "REGIONAL"
}

variable "allow_default_action" {
  type        = bool
  description = "Set to `true` for WAF to allow requests by default. Set to `false` for WAF to block requests by default."
  default     = true
}

variable "rules" {
  description = "List of WAF rules."
  default     = []
}

variable "ip_set_rules" {
  description = "List of WAF ip set rules to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "regular_expressions_regex_pattern_set" {
  description = "List of WAF ip set rules to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "regular_expressions_byte_match" {
  description = "List of WAF ip set rules to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "create_alb_association" {
  type        = bool
  description = "Whether to create alb association with WAF web acl"
  default     = true
}

variable "alb_arn" {
  type        = string
  description = "Application Load Balancer ARN"
  default     = ""
}

variable "alb_arn_list" {
  type        = list(string)
  description = "Application Load Balancer ARN list"
  default     = []
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

variable "visibility_config" {
  description = "Visibility config for WAFv2 web acl. https://www.terraform.io/docs/providers/aws/r/wafv2_web_acl.html#visibility-configuration"
  type        = map(string)
  default     = {}
}

variable "business_tags" {
    description   =   "Additional tags for the VPC"
    type          =   map(string)
    default       =   {}
}
variable "technical_tags" {
    description   =   "Additional tags for the VPC"
    type          =   map(string)
    default       =   {}
}

variable "log_destination_configs" {
  type        = string
  description = "The Amazon Kinesis Data Firehose Amazon Resource Name (ARNs) that you want to associate with the web ACL"
}

variable "resource_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the web ACL that you want to associate"
}