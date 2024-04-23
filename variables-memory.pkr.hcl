variable "memory" {
  description = "How much memory, in megabytes, to give the virtual machine. Defaults to 8192."
  type        = number
  default     = 8192
}

variable "ballooning_minimum" {
  description = "Setting this option enables KVM memory ballooning and defines the minimum amount of memory (in megabytes) the VM will have. Defaults to 1024."
  type        = number
  default     = 1024
}
