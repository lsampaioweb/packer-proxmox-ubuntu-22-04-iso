variable "machine" {
  description = "Set the machine type. i440fx or q35. Defaults to i440fx."
  type        = string
  default     = ""
}

variable "qemu_agent" {
  description = "Disables QEMU Agent option for this VM. When enabled, then qemu-guest-agent must be installed on the guest. When disabled, then ssh_host should be used. Defaults to true."
  type        = bool
  default     = true
}

variable "scsi_controller" {
  description = "The SCSI controller model to emulate. Can be lsi, lsi53c810, virtio-scsi-pci, virtio-scsi-single, megasas, or pvscsi. Defaults to virtio-scsi-single."
  type        = string
  default     = "virtio-scsi-single"
}
