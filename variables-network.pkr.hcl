variable "network_default_bridge" {
  description = "Default Proxmox bridge to attach the network adapter to."
  type        = string
  default     = "vmbr0"
}

variable "network_default_model" {
  description = "Default model of the virtual network adapter. Can be rtl8139, ne2k_pci, e1000, pcnet, virtio, ne2k_isa, i82551, i82557b, i82559er, vmxnet3, e1000-82540em, e1000-82544gc, or e1000-82545em."
  type        = string
  default     = "virtio"
}

variable "network_default_vlan_tag" {
  description = "Default VLAN tag for the network adapter. Empty for no tagging."
  type        = string
  default     = ""
}

variable "network_default_firewall" {
  description = "Default firewall setting for the network adapter. Enables firewall protection if true."
  type        = bool
  default     = false
}

variable "network_adapters" {
  description = "List of network adapters for the VM. Specify only the fields you want to override; defaults will be applied for unspecified fields."
  type        = list(map(string))

  default = [
    {
      bridge   = "vmbr0"
      model    = "virtio"
      vlan_tag = ""
      firewall = false
    }
  ]

  validation {
    condition = alltrue([
      for v in var.network_adapters : contains(["rtl8139", "ne2k_pci", "e1000", "pcnet", "virtio", "ne2k_isa", "i82551", "i82557b", "i82559er", "vmxnet3", "e1000-82540em", "e1000-82544gc", "e1000-82545em"], lookup(v, "model", "virtio"))
    ])
    error_message = "Model must be one of 'rtl8139', 'ne2k_pci', 'e1000', 'pcnet', 'virtio', 'ne2k_isa', 'i82551', 'i82557b', 'i82559er', 'vmxnet3', 'e1000-82540em', 'e1000-82544gc', or 'e1000-82545em'."
  }

  validation {
    condition = alltrue([
      for v in var.network_adapters : contains(["true", "false"], lookup(v, "firewall", "false"))
    ])
    error_message = "Firewall must be true or false."
  }
}
