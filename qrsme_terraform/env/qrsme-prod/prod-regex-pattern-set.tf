# aws_wafv2_regex_pattern_set.example:
resource "aws_wafv2_regex_pattern_set" "prod_regex_pattern_set" {

    name        = "prod-regex-pattern-set"
    scope       = "REGIONAL"

    regular_expression {
        regex_string = "(^/api/*)"
    }
}

output "prod-regex-pattern-set_arn" {
  description = "The ARN of the Regex Pattern."
  value       = join("", aws_wafv2_regex_pattern_set.prod_regex_pattern_set.*.arn)
}