source "file" "password" {
  # Generate random password.
  content = uuidv4()
  target  = local.random_password_file
}

build {
  name = "credentials"

  sources = ["source.file.password"]

  provisioner "shell-local" {
    inline = [
      # Ensure temp directory exists.
      "mkdir -p ${local.temp_dir} || exit 1",

      # Store password in keyring with UTC build key.
      "echo -n $(cat ${local.random_password_file}) | secret-tool store --label='${local.build_key}' password '${local.build_key}' || exit 1",

      # Encrypt password for cloud-init.
      "mkpasswd --method=SHA-512 --rounds=4096 $(secret-tool lookup password ${local.build_key}) > ${local.hashed_password_file} || exit 1",

      # Replace placeholders in user-data.
      # Use single quotes (') for static strings, double quotes (\") for shell expansion (e.g., $(cat ...)).
      "sed -e 's|{hostname}|${var.vm_name}|g' ${local.template_user_data} > ${local.final_user_data}",
      "sed -i 's|{username}|${var.ssh_username}|g' ${local.final_user_data}",
      "sed -i \"s|{encrypted_password}|$(cat ${local.hashed_password_file})|g\" ${local.final_user_data}"
    ]
  }
}
