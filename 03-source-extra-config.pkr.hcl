source "null" "extra-config" {
  communicator = "none"
}

build {
  name = "kvm-node"

  sources = ["source.null.extra-config"]

  provisioner "ansible" {
    playbook_file = "${local.path_ansible_scripts}/kvm_node.yml"

    ansible_env_vars = ["ANSIBLE_CONFIG=${local.path_ansible_scripts}/ansible.cfg"]

    inventory_file = "${local.path_ansible_scripts}/inventory/hosts"

    extra_arguments = [
      "-e",
      "node=${var.node} vm_id=${var.vm_id} disk_type=${var.disk_type} file=${var.disk_storage_pool}:base-${var.vm_id}-disk-0 hotplug=${var.hotplug}"
    ]
  }
}
