variable "machine" {
  description = "Set the machine type. Can be i440fx (or pc) or q35. Defaults to i440fx if not specified."
  type        = string
  default     = "q35"

  validation {
    condition     = contains(["pc", "q35"], var.machine)
    error_message = "Machine must be either 'pc' or 'q35' if specified."
  }
}

variable "qemu_agent" {
  description = "Enables QEMU Agent for this VM. Requires qemu-guest-agent to be installed on the guest. Defaults to true."
  type        = bool
  default     = true
}

variable "scsi_controller" {
  description = "The SCSI controller model to emulate. Can be lsi, lsi53c810, virtio-scsi-pci, virtio-scsi-single, megasas, or pvscsi. Defaults to virtio-scsi-single."
  type        = string
  default     = "virtio-scsi-single"

  validation {
    condition     = contains(["lsi", "lsi53c810", "virtio-scsi-pci", "virtio-scsi-single", "megasas", "pvscsi"], var.scsi_controller)
    error_message = "Scsi_controller must be one of 'lsi', 'lsi53c810', 'virtio-scsi-pci', 'virtio-scsi-single', 'megasas', or 'pvscsi'."
  }
}
