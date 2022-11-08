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
    "<down><down><down><end>",
    "<bs><bs><bs><bs><wait>",
    "autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 ",
    "ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "---<wait><f10><wait>"
  ]
}

variable "http_directory" {
  description = "Path to a directory to serve using an HTTP server. The files in this directory will be available over HTTP that will be requestable from the virtual machine."
  type        = string
  default     = "iso/autoinstall"
}