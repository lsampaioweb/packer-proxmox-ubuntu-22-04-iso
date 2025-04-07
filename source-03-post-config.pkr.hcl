source "null" "extra-config" {
  communicator = "none"
}

build {
  name = "post-config"

  sources = ["source.null.extra-config"]

  provisioner "ansible" {
    playbook_file = "${local.path_ansible_scripts}/kvm_setup.yml"

    ansible_env_vars = ["ANSIBLE_CONFIG=${local.path_ansible_scripts}/ansible.cfg"]

    inventory_file = "${local.path_ansible_scripts}/inventory/hosts"

    extra_arguments = [
      "--extra-vars",
      "node=${var.node} vm_id=${var.vm_id} hotplug=${var.hotplug} storage_pool=${local.storage_pool}"
    ]
  }
}
