variable "disk_default_storage_pool" {
  description = "Default storage pool for disks if not specified."
  type        = string
  default     = "local-lvm"
}

variable "disk_default_type" {
  description = "Default disk type if not specified. Can be scsi, sata, virtio, or ide."
  type        = string
  default     = "scsi"
}

variable "disk_default_format" {
  description = "Default disk format if not specified. Can be raw, cow, qcow, qed, qcow2, vmdk, or cloop."
  type        = string
  default     = "raw"
}

variable "disk_default_disk_size" {
  description = "Default disk size if not specified, including a unit suffix (e.g., 30G)."
  type        = string
  default     = "30G"
}

variable "disk_default_cache_mode" {
  description = "Default cache mode if not specified. Can be none, writethrough, writeback, unsafe, or directsync."
  type        = string
  default     = "none"
}

variable "disk_default_io_thread" {
  description = "Default io_thread setting if not specified. Enables I/O thread per storage controller."
  type        = bool
  default     = true
}

variable "disk_default_discard" {
  description = "Default discard setting if not specified. Relays TRIM commands to the underlying storage."
  type        = bool
  default     = true
}

variable "disk_default_ssd" {
  description = "Default ssd setting if not specified. Presents the drive as a solid-state drive to the guest."
  type        = bool
  default     = true
}

variable "disks" {
  description = "List of hard disks for the VM. Specify only the fields you want to override; defaults will be applied for unspecified fields."
  type        = list(map(string))

  default = [
    {
      storage_pool = "local-lvm"
      type         = "scsi"
      format       = "raw"
      disk_size    = "30G"
      cache_mode   = "none"
      io_thread    = true
      discard      = true
      ssd          = true
    }
  ]

  validation {
    condition = alltrue([
      for v in var.disks : contains(["scsi", "sata", "virtio", "ide"], lookup(v, "type", "scsi"))
    ])
    error_message = "Disk type must be one of 'scsi', 'sata', 'virtio', or 'ide'."
  }

  validation {
    condition = alltrue([
      for v in var.disks : contains(["raw", "cow", "qcow", "qed", "qcow2", "vmdk", "cloop"], lookup(v, "format", "raw"))
    ])
    error_message = "Disk format must be one of 'raw', 'cow', 'qcow', 'qed', 'qcow2', 'vmdk', or 'cloop'."
  }

  validation {
    condition = alltrue([
      for v in var.disks : can(regex("^[0-9]+[MGTP]$", lookup(v, "disk_size", "30G")))
    ])
    error_message = "Disk_size must be a number followed by a unit (M, G, T, P), e.g., '30G'."
  }

  validation {
    condition = alltrue([
      for v in var.disks : contains(["none", "writethrough", "writeback", "unsafe", "directsync"], lookup(v, "cache_mode", "none"))
    ])
    error_message = "Cache_mode must be one of 'none', 'writethrough', 'writeback', 'unsafe', or 'directsync'."
  }

  validation {
    condition = alltrue([
      for v in var.disks : contains(["true", "false"], lookup(v, "io_thread", "true"))
    ])
    error_message = "Io_thread must be true or false."
  }

  validation {
    condition = alltrue([
      for v in var.disks : contains(["true", "false"], lookup(v, "discard", "true"))
    ])
    error_message = "Discard must be true or false."
  }

  validation {
    condition = alltrue([
      for v in var.disks : contains(["true", "false"], lookup(v, "ssd", "true"))
    ])
    error_message = "Ssd must be true or false."
  }
}
