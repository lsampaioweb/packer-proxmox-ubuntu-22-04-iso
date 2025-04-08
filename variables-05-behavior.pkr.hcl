variable "onboot" {
  description = "Specifies whether a VM will be started during system bootup. Defaults to true."
  type        = bool
  default     = true
}

variable "boot" {
  description = "Override default boot order. Format example order=virtio0;ide2;net0. The default is order=scsi0;net0."
  type        = string
  default     = "order=scsi0;net0"
}

variable "disable_kvm" {
  description = "Disables KVM hardware virtualization. Defaults to false."
  type        = bool
  default     = false
}
