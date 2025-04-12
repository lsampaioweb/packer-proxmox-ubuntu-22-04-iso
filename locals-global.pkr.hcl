locals {
  iso_file             = replace(var.iso_full_file_path, "{iso_file}", var.iso_file)
  autoinstall_dir      = "${path.cwd}/iso/autoinstall"
  template_user_data   = "${local.autoinstall_dir}/safe-user-data-${var.bios}"
  final_user_data      = "${local.autoinstall_dir}/user-data"
  temp_dir             = "${local.autoinstall_dir}/tmp"
  random_password_file = "${local.temp_dir}/.random-password"
  hashed_password_file = "${local.temp_dir}/.hashed-password"
  path_ansible_scripts = "${path.cwd}/../ansible"

  # Fallback to the boot disk's storage pool if cloud_init_storage_pool is null, or to the default if disks is empty.
  storage_pool = var.cloud_init_storage_pool != null ? var.cloud_init_storage_pool : (length(var.disks) == 0) ? var.disk_default_storage_pool : lookup(var.disks[0], "storage_pool", var.disk_default_storage_pool)
}
