variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = ""
}

variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
  default     = ""
}

variable "role" {
  description = " The IAM role to attach to the policy"
  type        = string
  default     = ""
}