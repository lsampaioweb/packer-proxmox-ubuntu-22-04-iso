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
      "node=${var.node} vm_id=${var.vm_id} hotplug=${var.hotplug}"
    ]
  }

  dynamic "provisioner" {
    labels   = ["ansible"]
    for_each = var.disks
    iterator = disk

    content {
      playbook_file = "${local.path_ansible_scripts}/kvm_disk.yml"

      ansible_env_vars = ["ANSIBLE_CONFIG=${local.path_ansible_scripts}/ansible.cfg"]

      inventory_file = "${local.path_ansible_scripts}/inventory/hosts"

      extra_arguments = [
        "-e",
        "node=${var.node} vm_id=${var.vm_id} disk_type=${disk.value.type}${disk.key} file=${disk.value.storage_pool}:base-${var.vm_id}-disk-${disk.key}"
      ]
    }
  }
}
