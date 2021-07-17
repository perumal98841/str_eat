module "prod_seller_ui_log_group" {
  source      = "../../modules/log-group"
  name              = "prod_seller_ui_log_group_us_east_2"
  retention_in_days = 30
}