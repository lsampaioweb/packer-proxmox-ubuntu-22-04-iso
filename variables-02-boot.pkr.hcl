variable "iso_type" {
  description = "Bus type that the ISO will be mounted on. Can be ide, sata or scsi. Defaults to ide."
  type        = string
  default     = "ide"
  validation {
    condition     = contains(["ide", "sata", "scsi"], var.iso_type)
    error_message = "Iso_type must be one of 'ide', 'sata', or 'scsi'."
  }
}

variable "iso_file" {
  description = "Name of the ISO file to boot from (e.g., 'ubuntu-24.04.2-live-server-amd64.iso'). Used in iso_full_file_path."
  type        = string
}

variable "iso_full_file_path" {
  description = "Path to the ISO file in Proxmox datastore format (e.g., 'local:iso/{iso_file}'). The '{iso_file}' placeholder will be replaced with the iso_file value."
  type        = string
  default     = "local:iso/{iso_file}"
}

variable "iso_checksum" {
  description = "Checksum (type:value) of the ISO file, e.g., 'sha256:abc123...'."
  type        = string
  default     = null
}

variable "unmount_iso" {
  description = "If true, remove the mounted ISO from the template after finishing. Defaults to true."
  type        = bool
  default     = true
}

variable "boot_wait" {
  description = "Gives the virtual machine some time to actually load the ISO."
  type        = string
  default     = "5s"
  validation {
    condition     = can(regex("^[0-9]+[smh]$", var.boot_wait))
    error_message = "Boot_wait must be a duration like '30s', '10m' or '1h'."
  }
}

variable "boot_command" {
  description = "It specifies the keys to type when the virtual machine is first booted in order to start the OS installer."
  type        = list(string)
  default = [
    "e<wait>",
    "<down><wait><down><wait><down><wait><end><wait>",
    "<bs><wait><bs><wait><bs><wait><bs><wait>",
    "autoinstall ip=dhcp net.ifnames=0 biosdevname=0 ipv6.disable=1 ",
    "ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "---<wait><f10><wait>"
  ]
}

variable "http_directory" {
  description = "Path to a directory to serve using an HTTP server. The files in this directory will be available over HTTP that will be requestable from the virtual machine."
  type        = string
  default     = "iso/autoinstall"
}

variable "http_port_min" {
  description = "The minimum port to use for the HTTP server started to serve the http_directory. Default is 8000."
  type        = number
  default     = 8100
  validation {
    condition     = var.http_port_min >= 1024 && var.http_port_min <= 65535
    error_message = "Http_port_min must be between 1024 and 65535."
  }
}

variable "http_port_max" {
  description = "The maximum port to use for the HTTP server started to serve the http_directory. Default is 9000."
  type        = number
  default     = 8200
  validation {
    condition     = var.http_port_max >= 1024 && var.http_port_max <= 65535
    error_message = "Http_port_max must be between 1024 and 65535."
  }
}
