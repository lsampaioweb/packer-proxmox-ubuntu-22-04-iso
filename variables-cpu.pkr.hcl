variable "sockets" {
  description = "How many CPU sockets to give the virtual machine. Defaults to 1."
  type        = number
  default     = 1
}

variable "cores" {
  description = "How many CPU cores to give the virtual machine. Defaults to 4."
  type        = number
  default     = 4
}

variable "cpu_type" {
  description = "The CPU type to emulate. Defaults to x86-64-v2-AES."
  type        = string
  default     = "x86-64-v2-AES"
}
