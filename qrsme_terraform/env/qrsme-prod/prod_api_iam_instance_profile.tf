module "prod_api_iam_instance_profile" {
  source = "../../modules/iam_instance_profile"
  profile_name = "prod_api_iam_instance_profile"
  role = module.prod_api_iam_role.name
}