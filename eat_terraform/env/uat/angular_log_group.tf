module "uat_angular_log_group" {
  source      = "../../modules/log-group"
  name              = "uat_angular_log_group_us_east_2"
  retention_in_days = 30
}