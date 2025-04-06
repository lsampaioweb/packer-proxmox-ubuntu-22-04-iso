variable "bios" {
  description = "The BIOS to use, options are seabios or ovmf for UEFI. The default is seabios."
  type        = string
  default     = "seabios"
  validation {
    condition     = contains(["seabios", "ovmf"], var.bios)
    error_message = "Bios must be either 'seabios' or 'ovmf'."
  }
}

variable "efi_config" {
  description = "The efidisk storage options. This needs to be set if you use ovmf uefi boot."
  type = object({
    # Name of the Proxmox storage pool to store the EFI disk on.
    efi_storage_pool = string
    # The format of the file backing the disk. Can be raw, cow, qcow, qed, qcow2, vmdk or cloop. Defaults to raw.
    efi_format = string
    # Specifies the version of the OVMF firmware to be used. Can be 2m or 4m. Defaults to 4m.
    efi_type = string
    # Whether Microsoft Standard Secure Boot keys should be pre-loaded on the EFI disk. Defaults to false.
    pre_enrolled_keys = bool
  })
  default = {
    efi_storage_pool  = null
    efi_format        = null
    efi_type          = null
    pre_enrolled_keys = null
  }

  validation {
    condition     = var.efi_config.efi_format == null || contains(["raw", "cow", "qcow", "qed", "qcow2", "vmdk", "cloop"], var.efi_config.efi_format)
    error_message = "Efi_format must be one of 'raw', 'cow', 'qcow', 'qed', 'qcow2', 'vmdk', or 'cloop' if specified."
  }

  validation {
    condition     = var.efi_config.efi_type == null || contains(["2m", "4m"], var.efi_config.efi_type)
    error_message = "Efi_type must be either '2m' or '4m' if specified."
  }
}
