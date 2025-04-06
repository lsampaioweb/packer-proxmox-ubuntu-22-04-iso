variable "iso_type" {
  description = "Bus type that the ISO will be mounted on. Can be ide, sata or scsi. Defaults to ide."
  type        = string
  default     = "ide"
}

variable "iso_file" {
  description = "Name to the ISO file to boot from."
  type        = string
}

variable "iso_full_file_path" {
  description = "Path to the ISO file to boot from, expressed as a proxmox datastore path."
  type        = string
  default     = "CephFS:iso/{iso_file}"
}

variable "unmount_iso" {
  description = "If true, remove the mounted ISO from the template after finishing. Defaults to false."
  type        = bool
  default     = true
}

variable "iso_checksum" {
  description = "Checksum (type:value) of the ISO file, e.g., 'sha256:abc123...'."
  type        = string
  default     = null
}

variable "boot_wait" {
  description = "Gives the virtual machine some time to actually load the ISO."
  type        = string
  default     = "5s"
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
}

variable "http_port_max" {
  description = "The maximum port to use for the HTTP server started to serve the http_directory. Default is 9000."
  type        = number
  default     = 8200
}
