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
