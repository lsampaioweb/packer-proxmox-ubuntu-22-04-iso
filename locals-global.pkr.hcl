locals {
  iso_file = replace(var.iso_full_file_path, "{iso_file}", var.iso_file)

  path_user_data           = "${path.cwd}/iso/autoinstall"
  path_safe_user_data      = "${local.path_user_data}/safe-user-data"
  path_encrypted_user_data = "${local.path_user_data}/user-data"

  path_temp_files         = "${local.path_user_data}/tmp"
  path_random_password    = "${local.path_temp_files}/.random-password"
  path_encrypted_password = "${local.path_temp_files}/.encrypted-password"

  path_ansible_scripts = "${path.cwd}/../ansible"

  ssh_password = file(local.path_random_password)
}
