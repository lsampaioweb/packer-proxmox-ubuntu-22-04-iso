variable "ssh_username" {
  description = "User name that Packer will use to connect to the VM through SSH."
  type        = string
  default     = "usr_packer"
}

variable "ssh_timeout" {
  description = "The time to wait for SSH to become available."
  type        = string
  default     = "20m"
}

variable "use_proxy" {
  description = "When true, set up a localhost proxy adapter so that Ansible has an IP address to connect to, even if your guest does not have an IP address. For example, the adapter is necessary for Docker builds to use the Ansible provisioner. If you set this option to false, but Packer cannot find an IP address to connect Ansible to, it will automatically set up the adapter anyway. The default is true."
  type        = bool
  default     = true
}
