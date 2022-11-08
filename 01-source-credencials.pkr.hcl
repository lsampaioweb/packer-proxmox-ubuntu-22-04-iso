source "file" "password" {
  # Create a unique and big string and save it to the file. 
  # e.g: 20b33efa-9302-4b1a-8a38-403d57c8291a
  content = uuidv4()
  target  = local.path_random_password
}

build {
  name = "credencials"

  sources = ["source.file.password"]

  provisioner "shell-local" {
    inline = [
      # Generate a random password and save it in the secret manager.
      "echo -n $(cat ${local.path_random_password}) | secret-tool store --label='${var.vm_name}' password '${var.vm_name}'",

      # Get the password and create a file with its encrypted value.
      "mkpasswd --method=SHA-512 --rounds=4096 $(secret-tool lookup password ${var.vm_name}) > ${local.path_encrypted_password}",

      # Replace the content of the {hostname} placeholder with the name of this project.
      "sed -e \"s|{hostname}|${var.vm_name}|g\" ${local.path_safe_user_data} > ${local.path_encrypted_user_data}",

      # Replace the content of the {username} placeholder with the packer user name.
      "sed -i \"s|{username}|${var.ssh_username}|g\" ${local.path_encrypted_user_data}",

      # Replace the content of the {encrypted_password} placeholder with the encrypted password that was created.
      "sed -i \"s|{encrypted_password}|$(cat ${local.path_encrypted_password})|g\" ${local.path_encrypted_user_data}"
    ]
  }
}
