variable "proxmox_url" {
  description = "URL to the Proxmox API, including the full path. https://<server>:<port>/api2/json"
  type        = string
}

variable "username" {
  description = "Username when authenticating to Proxmox, including the realm. For example user@pve to use the local Proxmox realm. When used with token, it would look like this: user@pve!TokenName"
  type        = string
  default     = "packer@pve!packer"
}

variable "token" {
  description = "Token for authenticating Proxmox API calls. Takes precedence over password if both are set. Can be set via PKR_VAR_PROXMOX_PACKER_TOKEN env var."
  type        = string
  sensitive   = true
  default     = env("PKR_VAR_PROXMOX_PACKER_TOKEN") != "" ? env("PKR_VAR_PROXMOX_PACKER_TOKEN") : null
}

variable "password" {
  description = "Password for Proxmox user auth. Used if token is unset. Can be set via PKR_VAR_PROXMOX_PACKER_PASSWORD env var."
  type        = string
  sensitive   = true
  default     = env("PKR_VAR_PROXMOX_PACKER_PASSWORD") != "" ? env("PKR_VAR_PROXMOX_PACKER_PASSWORD") : null
}

variable "insecure_skip_tls_verify" {
  description = "Skip TLS verification for self-signed certificates."
  type        = bool
  default     = false
}

variable "task_timeout" {
  description = "The timeout for Proxmox API operations, e.g. clones. Defaults to 20 minutes."
  type        = string
  default     = "20m"
  validation {
    condition     = can(regex("^[0-9]+[smh]$", var.task_timeout))
    error_message = "Task timeout must be a duration like '30s', '10m' or '1h'."
  }
}
