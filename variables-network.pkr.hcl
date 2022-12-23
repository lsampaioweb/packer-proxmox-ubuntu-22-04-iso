variable "network_adapters" {
  description = "Network configuration for the VM."
  type = map(object({
    # Required. Which Proxmox bridge to attach the adapter to.
    bridge   = string
    # Model of the virtual network adapter. Can be rtl8139, ne2k_pci, e1000, pcnet, virtio, ne2k_isa, i82551, i82557b, i82559er, vmxnet3, e1000-82540em, e1000-82544gc or e1000-82545em. Defaults to e1000.
    model    = string
    # If the adapter should tag packets. Defaults to no tagging.
    vlan_tag = string
    # If the interface should be protected by the firewall. Defaults to false.
    firewall = bool
  }))

  default = {
    "01" = {
      # WAN
      bridge   = "vmbr0"
      model    = "virtio"
      vlan_tag = ""
      firewall = false
    }
  }
}
