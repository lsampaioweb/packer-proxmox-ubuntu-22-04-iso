variable "memory" {
  description = "How much memory, in megabytes, to give the virtual machine. Typically between 512 MB and 128 GB. Defaults to 8192 (8 GB)."
  type        = number
  default     = 8192

  validation {
    condition     = var.memory >= 512 && var.memory <= 131072
    error_message = "Memory must be between 512 MB and 131072 MB (128 GB)."
  }
}

variable "ballooning_minimum" {
  description = "Enables KVM memory ballooning when non-zero and sets the minimum memory (in megabytes) the VM will have. Must be 0 (disabled) or between 512 MB and 131072 MB (128 GB). Defaults to 0 (disabled)."
  type        = number
  default     = 0

  validation {
    condition     = var.ballooning_minimum == 0 || (var.ballooning_minimum >= 512 && var.ballooning_minimum <= 131072)
    error_message = "Ballooning_minimum must be 0 (disabled) or between 512 MB and 131072 MB (128 GB)."
  }
}
