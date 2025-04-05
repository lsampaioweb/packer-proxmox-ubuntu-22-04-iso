locals {
  # Unique key for this build.
  # Use vm_name alone if only one template per type (e.g., ubuntu-24-04-server-raw) will exist.
  # build_key = "${var.vm_name}"
  # Add date if multiple templates of the same vm_name might be created (e.g., ubuntu-24-04-server-raw-2025-04-15-17-22).
  build_key = "${var.vm_name}-${formatdate("YYYY-MM-DD-hh-mm", timestamp())}"

  iso_file             = replace(var.iso_full_file_path, "{iso_file}", var.iso_file)
  autoinstall_dir      = "${path.cwd}/iso/autoinstall"
  template_user_data   = "${local.autoinstall_dir}/safe-user-data-${var.bios}"
  final_user_data      = "${local.autoinstall_dir}/user-data"
  temp_dir             = "${local.autoinstall_dir}/tmp"
  random_password_file = "${local.temp_dir}/.random-password"
  hashed_password_file = "${local.temp_dir}/.hashed-password"
  path_ansible_scripts = "${path.cwd}/../ansible"
}
