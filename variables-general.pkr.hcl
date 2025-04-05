variable "build_name" {
  description = "The name of the build."
  type        = string
  default     = "ubuntu"
}

variable "node" {
  description = "The node in the Proxmox cluster to create the template."
  type        = string
}

variable "vm_id" {
  description = "The ID used to reference the virtual machine. This will also be the ID of the final template. If not given, the next free ID on the node will be used."
  type        = number
}

variable "vm_name" {
  description = "Name of the virtual machine during creation. If not given, a isotime will be used."
  type        = string
}

variable "pool" {
  description = "Name of resource pool to create virtual machine in."
  type        = string
  default     = "Template"
}

variable "bios" {
  description = "The BIOS to use, options are seabios or ovmf for UEFI. The default is seabios."
  type        = string
  default     = "seabios"
}

variable "efi_config" {
  description = "The efidisk storage options. This needs to be set if you use ovmf uefi boot."
  type = object({
    # Name of the Proxmox storage pool to store the EFI disk on.
    efi_storage_pool = string,
    # The format of the file backing the disk. Can be raw, cow, qcow, qed, qcow2, vmdk or cloop. Defaults to raw.
    efi_format = string,
    # Specifies the version of the OVMF firmware to be used. Can be 2m or 4m. Defaults to 4m.
    efi_type = string,
    # Whether Microsoft Standard Secure Boot keys should be pre-loaded on the EFI disk. Defaults to false.
    pre_enrolled_keys = bool
  })

  default = {
    efi_storage_pool  = null
    efi_format        = null
    efi_type          = null
    pre_enrolled_keys = null
  }
}

variable "onboot" {
  description = "Specifies whether a VM will be started during system bootup. Defaults to true."
  type        = bool
  default     = true
}

variable "disable_kvm" {
  description = "Disables KVM hardware virtualization. Defaults to false for best performance."
  type        = bool
  default     = false
}

variable "task_timeout" {
  description = "The timeout for Promox API operations, e.g. clones. Defaults to 1 minute."
  type        = string
  default     = "20m"
}

variable "template_description" {
  description = "Description of the template, visible in the Proxmox interface."
  type        = string
  default     = "Template generated by Packer on {{ formatdate('YYYY-MM-DD hh:mm', timestamp()) }}."
}
