locals {
  is_t_instance_type = replace(var.instance_type, "/^t(2|3|3a){1}\\..*$/", "1") == "1" ? true : false
}

resource "aws_instance" "this" {
  count = var.instance_count

  ami              = var.ami
  instance_type    = var.instance_type
  user_data        = var.user_data
  user_data_base64 = var.user_data_base64
  subnet_id = length(var.network_interface) > 0 ? null : element(
    distinct(compact(concat([var.subnet_id], var.subnet_ids))),
    count.index,
  )
  key_name               = var.key_name
  monitoring             = var.monitoring
  get_password_data      = var.get_password_data
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip_address
  private_ip                  = length(var.private_ips) > 0 ? element(var.private_ips, count.index) : var.private_ip



  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
    }
  }

  source_dest_check                    = length(var.network_interface) > 0 ? null : var.source_dest_check
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  placement_group                      = var.placement_group
  tenancy                              = var.tenancy

  tags = merge(
    {
      "Name" = var.instance_count > 1 || var.use_num_suffix ? format("%s${var.num_suffix_format}", var.name, count.index + 1) : var.name
    },
    var.business_tags,
    var.technical_tags,
  )
}