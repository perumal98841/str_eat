variable "profile_name" {
  description = "IAM role name"
  type        = string
  default     = ""
}
variable "role" {
  description = " The IAM role to attach to the policy"
  type        = string
  default     = ""
}