variable "iso_file" {
  description = "Name to the ISO file to boot from"
  type        = string
}

variable "iso_full_file_path" {
  description = "Path to the ISO file to boot from, expressed as a proxmox datastore path."
  type        = string
  default     = "CephFS_Bronze:iso/{iso_file}"
}

variable "os" {
  description = "The operating system. Can be wxp, w2k, w2k3, w2k8, wvista, win7, win8, win10, l24 (Linux 2.4), l26 (Linux 2.6+), solaris or other. Defaults to other."
  type        = string
  default     = "l26"
}
