variable "ssh_username" {
  description = "User name that Packer will use to connect to the VM through SSH."
  type        = string
  default     = "usr_packer"
}

variable "use_proxy" {
  description = "When true, set up a localhost proxy adapter so that Ansible has an IP address to connect to, even if your guest does not have an IP address. For example, the adapter is necessary for Docker builds to use the Ansible provisioner. If you set this option to false, but Packer cannot find an IP address to connect Ansible to, it will automatically set up the adapter anyway. The default is true."
  type        = bool
  default     = true
}

variable "ssh_private_key_file" {
  description = "Path to an SSH private key file for authentication."
  type        = string
  default     = null
}

variable "ssh_timeout" {
  description = "The time to wait for SSH to become available."
  type        = string
  default     = "20m"

  validation {
    condition     = can(regex("^[0-9]+[smh]$", var.ssh_timeout))
    error_message = "Ssh_timeout must be a duration like '30s', '10m' or '1h'."
  }
}
