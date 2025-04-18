variable "bios" {
  description = "The BIOS to use, options are seabios or ovmf for UEFI. The default is ovmf."
  type        = string
  default     = "ovmf"

  validation {
    condition     = contains(["seabios", "ovmf"], var.bios)
    error_message = "Bios must be either 'seabios' or 'ovmf'."
  }
}

variable "efi_default_storage_pool" {
  description = "Default storage pool for the EFI disk if not specified."
  type        = string
  default     = null
}

variable "efi_default_format" {
  description = "Default format of the EFI disk if not specified. Can be raw, cow, qcow, qed, qcow2, vmdk, or cloop."
  type        = string
  default     = "raw"
}

variable "efi_default_type" {
  description = "Default version of the OVMF firmware if not specified. Can be 2m or 4m."
  type        = string
  default     = "4m"
}

variable "efi_default_pre_enrolled_keys" {
  description = "Default setting for pre-enrolling Microsoft Standard Secure Boot keys on the EFI disk if not specified."
  type        = bool
  default     = false
}

variable "efi_config" {
  description = "The efidisk storage options. This needs to be set if you use ovmf uefi boot. Specify only the fields you want to override; defaults will be applied for unspecified fields."
  type        = map(string)

  default = {
    efi_format        = "raw"
    efi_type          = "4m"
    pre_enrolled_keys = "false"
  }

  validation {
    condition     = contains(["raw", "cow", "qcow", "qed", "qcow2", "vmdk", "cloop"], lookup(var.efi_config, "efi_format", "raw"))
    error_message = "Efi_format must be one of 'raw', 'cow', 'qcow', 'qed', 'qcow2', 'vmdk', or 'cloop'."
  }

  validation {
    condition     = contains(["2m", "4m"], lookup(var.efi_config, "efi_type", "4m"))
    error_message = "Efi_type must be either '2m' or '4m'."
  }

  validation {
    condition     = contains(["true", "false"], lookup(var.efi_config, "pre_enrolled_keys", "false"))
    error_message = "Pre_enrolled_keys must be true or false."
  }
}
