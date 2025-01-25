variable "os" {
  description = "The operating system. Can be wxp, w2k, w2k3, w2k8, wvista, win7, win8, win10, l24 (Linux 2.4), l26 (Linux 2.6+), solaris or other. Defaults to l26."
  type        = string
  default     = "l26"
}

variable "vga" {
  description = "The graphics adapter to use. Can be cirrus, none, qxl, qxl2, qxl3, qxl4, serial0, serial1, serial2, serial3, std, virtio, vmware. Defaults to std and 16M."
  type = object({
    type   = string,
    memory = number
    }
  )

  default = {
    type   = null,
    memory = null
  }
}

variable "hotplug" {
  description = "Selectively enable hotplug features. This is a comma separated list of hotplug features: disk, network, cpu, memory, usb and cloudinit. Use 0 to disable hotplug completely. Defaults to disk,network,cpu."
  type        = string
  default     = "disk,network,cpu"
}
