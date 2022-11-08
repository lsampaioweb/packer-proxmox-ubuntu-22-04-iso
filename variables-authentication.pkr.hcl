variable "proxmox_url" {
  description = "URL to the Proxmox API, including the full path. https://<server>:<port>/api2/json"
  type        = string
  default     = "https://kvm.homelab:8006/api2/json"
}

variable "username" {
  description = "Username when authenticating to Proxmox, including the realm. For example user@pve to use the local Proxmox realm. When used with token, it would look like this: user@pve!TokenName"
  type        = string
  default     = "packer@pve!packer"
}

variable "token" {
  description = "Packer Token for authenticating API calls."
  type        = string
  sensitive   = true
  default     = env("PKR_VAR_PROXMOX_PACKER_TOKEN")

  validation {
    condition     = length(var.token) > 0
    error_message = "The Packer Token for authenticating API calls in Proxmox is required."
  }
}
