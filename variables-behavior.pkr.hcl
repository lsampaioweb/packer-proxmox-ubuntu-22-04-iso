variable "onboot" {
  description = "Specifies whether a VM will be started during system bootup. Defaults to true."
  type        = bool
  default     = true
}

variable "disable_kvm" {
  description = "Disables KVM hardware virtualization. Defaults to false for best performance."
  type        = bool
  default     = false
}
