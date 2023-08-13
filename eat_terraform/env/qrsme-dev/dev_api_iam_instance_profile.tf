module "dev_api_iam_instance_profile" {
  source = "../../modules/iam_instance_profile"
  profile_name = "dev_api_iam_instance_profile"
  role = module.dev_api_iam_role.name
}