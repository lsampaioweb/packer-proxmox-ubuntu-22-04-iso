source "proxmox-iso" "template" {
  # https://www.packer.io/plugins/builders/proxmox/iso

  # Proxmox authentication
  proxmox_url = var.proxmox_url
  username    = var.username
  token       = var.token

  # General
  node                 = var.node
  vm_id                = var.vm_id
  vm_name              = var.vm_name
  pool                 = var.pool
  bios                 = var.bios
  onboot               = var.onboot
  task_timeout         = var.task_timeout
  template_description = var.template_description
  unmount_iso          = var.unmount_iso

  # OS
  iso_file = local.iso_file
  os       = var.os
  vga {
    type   = var.vga.type
    memory = var.vga.memory
  }

  # System
  machine         = var.machine
  qemu_agent      = var.qemu_agent
  scsi_controller = var.scsi_controller

  # CPU
  sockets  = var.sockets
  cores    = var.cores
  cpu_type = var.cpu_type

  # Memory
  memory = var.memory

  # Hard Disk
  dynamic "disks" {
    for_each = var.disks

    content {
      disk_size    = disks.value.size
      type         = disks.value.type
      storage_pool = disks.value.storage_pool
      format       = disks.value.format
      cache_mode   = disks.value.cache_mode
      io_thread    = disks.value.io_thread
    }
  }

  # Networks
  dynamic "network_adapters" {
    for_each = var.network_adapters

    content {
      bridge   = network_adapters.value.bridge
      model    = network_adapters.value.model
      vlan_tag = network_adapters.value.vlan_tag
      firewall = network_adapters.value.firewall
    }
  }

  # Boot Command
  boot_wait      = var.boot_wait
  http_directory = var.http_directory
  boot_command   = var.boot_command

  # SSH Connection with the template
  ssh_username = var.ssh_username
  ssh_password = file(local.path_random_password)
  ssh_timeout  = var.ssh_timeout
}

build {
  name = var.build_name

  sources = ["source.proxmox-iso.template"]

  provisioner "ansible" {
    playbook_file = "${local.path_ansible_scripts}/template.yml"
    user          = var.ssh_username
    use_proxy     = var.use_proxy

    ansible_env_vars = ["ANSIBLE_CONFIG=${local.path_ansible_scripts}/ansible.cfg"]

    // This is a bug/workaround and I didn't like it. 
    // TODO - Find a better solution.
    ansible_ssh_extra_args = ["-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa"]
  }
}
