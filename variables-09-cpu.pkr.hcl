variable "sockets" {
  description = "How many CPU sockets to give the virtual machine. Defaults to 1."
  type        = number
  default     = 1

  validation {
    condition     = var.sockets >= 1 && var.sockets <= 128
    error_message = "Sockets must be between 1 and 128."
  }
}

variable "cores" {
  description = "How many CPU cores to give the virtual machine. Defaults to 4."
  type        = number
  default     = 4

  validation {
    condition     = var.cores >= 1 && var.cores <= 128
    error_message = "Cores must be between 1 and 128."
  }
}

variable "cpu_type" {
  description = "The CPU type to emulate. Common options include 'kvm64', 'host', 'x86-64-v2-AES', or 'max'. Defaults to x86-64-v2-AES."
  type        = string
  default     = "x86-64-v2-AES"
}
