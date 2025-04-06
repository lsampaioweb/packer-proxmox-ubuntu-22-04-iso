variable "hotplug" {
  description = "Selectively enable hotplug features. This is a comma separated list of hotplug features: disk, network, cpu, memory, usb and cloudinit. Use 0 to disable hotplug completely. Defaults to disk,network,cpu."
  type        = string
  default     = "disk,network,cpu"

  validation {
    condition     = var.hotplug == "0" || alltrue([for v in split(",", var.hotplug) : contains(["disk", "network", "cpu", "memory", "usb", "cloudinit"], v)])
    error_message = "Hotplug must be '0' or a comma-separated list of 'disk', 'network', 'cpu', 'memory', 'usb', 'cloudinit'."
  }
}
