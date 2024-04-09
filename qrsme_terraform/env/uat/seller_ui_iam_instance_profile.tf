module "uat_seller_ui_iam_instance_profile" {
  source = "../../modules/iam_instance_profile"
  profile_name = "uat_seller_ui_iam_instance_profile"
  role = module.uat_seller_ui_iam_role.name
}