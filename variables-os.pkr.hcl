variable "os" {
  description = "The operating system. Can be wxp, w2k, w2k3, w2k8, wvista, win7, win8, win10, l24 (Linux 2.4), l26 (Linux 2.6+), solaris or other. Defaults to l26."
  type        = string
  default     = "l26"

  validation {
    condition     = contains(["wxp", "w2k", "w2k3", "w2k8", "wvista", "win7", "win8", "win10", "l24", "l26", "solaris", "other"], var.os)
    error_message = "Os must be one of 'wxp', 'w2k', 'w2k3', 'w2k8', 'wvista', 'win7', 'win8', 'win10', 'l24', 'l26', 'solaris', or 'other'."
  }
}

variable "vga" {
  description = "The graphics adapter to use. Can be cirrus, none, qxl, qxl2, qxl3, qxl4, serial0, serial1, serial2, serial3, std, virtio, vmware. Defaults to std and 16M."
  type = object({
    type   = string
    memory = number
  })
  default = {
    type   = "std"
    memory = 16
  }

  validation {
    condition     = contains(["cirrus", "none", "qxl", "qxl2", "qxl3", "qxl4", "serial0", "serial1", "serial2", "serial3", "std", "virtio", "vmware"], var.vga.type)
    error_message = "Vga type must be one of 'cirrus', 'none', 'qxl', 'qxl2', 'qxl3', 'qxl4', 'serial0', 'serial1', 'serial2', 'serial3', 'std', 'virtio', or 'vmware'."
  }
  validation {
    condition     = var.vga.memory >= 4 && var.vga.memory <= 512
    error_message = "Vga memory must be between 4 and 512 MB."
  }
}
