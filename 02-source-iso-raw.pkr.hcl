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
  onboot               = var.onboot
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
  qemu_agent      = var.qemu_agent
  scsi_controller = var.scsi_controller

  # CPU
  sockets  = var.sockets
  cores    = var.cores
  cpu_type = var.cpu_type

  # Memory
  memory = var.memory

  # Hard Disk  
  disks {
    type              = var.disk_type
    storage_pool      = var.disk_storage_pool
    storage_pool_type = var.disk_storage_pool_type
    disk_size         = var.disk_disk_size
    cache_mode        = var.disk_cache_mode
    format            = var.disk_format
    io_thread         = var.disk_io_thread
  }

  # Network
  network_adapters {
    bridge   = var.network_adapters_0_bridge
    vlan_tag = var.network_adapters_0_vlan_tag
    model    = var.network_adapters_0_model
    firewall = var.network_adapters_0_firewall
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

    ansible_env_vars = ["ANSIBLE_CONFIG=${local.path_ansible_scripts}/ansible.cfg"]

    // This is a bug/workaround and I didn't like it. 
    // TODO - Find a better solution.
    ansible_ssh_extra_args = ["-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa"]
  }
}
