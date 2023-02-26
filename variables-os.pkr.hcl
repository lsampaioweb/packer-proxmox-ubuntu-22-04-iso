variable "iso_file" {
  description = "Name to the ISO file to boot from"
  type        = string
}

variable "iso_full_file_path" {
  description = "Path to the ISO file to boot from, expressed as a proxmox datastore path."
  type        = string
  default     = "CephFS_Bronze:iso/{iso_file}"
}

variable "os" {
  description = "The operating system. Can be wxp, w2k, w2k3, w2k8, wvista, win7, win8, win10, l24 (Linux 2.4), l26 (Linux 2.6+), solaris or other. Defaults to other."
  type        = string
  default     = "l26"
}

variable "vga" {
  description = "The graphics adapter to use. Can be cirrus, none, qxl, qxl2, qxl3, qxl4, serial0, serial1, serial2, serial3, std, virtio, vmware. Defaults to std."
  type = object({
    type   = string,
    memory = number
    }
  )

  default = {
    type : "std",
    memory : 16
  }
}

variable "hotplug" {
  description = "Selectively enable hotplug features. This is a comma separated list of hotplug features: disk, network, cpu, memory, usb and cloudinit. Use 0 to disable hotplug completely."
  type        = string
  default     = "disk,network,cpu"
}
