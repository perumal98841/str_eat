module "uat_angular_iam_instance_profile" {
  source = "../../modules/iam_instance_profile"
  profile_name = "uat_angular_iam_instance_profile"
  role = module.uat_angular_iam_role.name
}