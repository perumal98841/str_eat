module "prod_angular_iam_instance_profile" {
  source = "../../modules/iam_instance_profile"
  profile_name = "prod_angular_iam_instance_profile"
  role = module.prod_angular_iam_role.name
}