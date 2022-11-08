variable "qemu_agent" {
  description = "Disables QEMU Agent option for this VM. When enabled, then qemu-guest-agent must be installed on the guest. When disabled, then ssh_host should be used. Defaults to true."
  type        = bool
  default     = true
}

variable "scsi_controller" {
  description = "The SCSI controller model to emulate. Can be lsi, lsi53c810, virtio-scsi-pci, virtio-scsi-single, megasas, or pvscsi. Defaults to lsi."
  type        = string
  default     = "virtio-scsi-single"
}
