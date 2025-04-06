variable "cloud_init" {
  description = "If true, add an empty Cloud-Init CDROM drive after the virtual machine has been converted to a template. Defaults to false."
  type        = bool
  default     = false
}

variable "cloud_init_disk_type" {
  description = "The type of Cloud-Init disk. Can be scsi, sata, or ide. Defaults to ide."
  type        = string
  default     = "ide"
  validation {
    condition     = contains(["scsi", "sata", "ide"], var.cloud_init_disk_type)
    error_message = "Cloud_init_disk_type must be one of 'scsi', 'sata', or 'ide'."
  }
}

variable "cloud_init_storage_pool" {
  description = "Name of the Proxmox storage pool to store the Cloud-Init CDROM on. If not given, the storage pool of the boot device will be used."
  type        = string
  default     = null
}
