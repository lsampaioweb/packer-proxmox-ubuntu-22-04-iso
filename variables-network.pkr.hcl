variable "network_adapters_0_bridge" {
  description = "Required. Which Proxmox bridge to attach the adapter to."
  type        = string
  default     = "vmbr0"
}

variable "network_adapters_0_vlan_tag" {
  description = "If the adapter should tag packets. Defaults to no tagging."
  type        = string
  default     = ""
}

variable "network_adapters_0_model" {
  description = "Model of the virtual network adapter. Can be rtl8139, ne2k_pci, e1000, pcnet, virtio, ne2k_isa, i82551, i82557b, i82559er, vmxnet3, e1000-82540em, e1000-82544gc or e1000-82545em. Defaults to e1000."
  type        = string
  default     = "virtio"
}

variable "network_adapters_0_firewall" {
  description = "If the interface should be protected by the firewall. Defaults to false."
  type        = bool
  default     = false
}
