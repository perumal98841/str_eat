module "eatzos_iam_instance_profile" {
  source = "../../modules/iam_instance_profile"
  profile_name = "eatzos-prod-instance-profile"
  role = module.eatzos_iam_role_master.name
}