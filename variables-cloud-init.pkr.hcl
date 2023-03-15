variable "cloud_init" {
  description = "If true, add an empty Cloud-Init CDROM drive after the virtual machine has been converted to a template. Defaults to true."
  type        = bool
  default     = false
}

variable "cloud_init_storage_pool" {
  description = "Name of the Proxmox storage pool to store the Cloud-Init CDROM on. If not given, the storage pool of the boot device will be used."
  type        = string
  default     = "Ceph_Silver"
}