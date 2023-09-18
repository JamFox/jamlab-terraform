# Proxmox Provider
variable "pm_api_url" {
  type        = string
  description = "This is the target Proxmox API endpoint."
}

variable "pm_api_token_id" {
  type        = string
  description = "This is an API token you have previously created for a specific user."
  sensitive   = true
}

variable "pm_api_token_secret" {
  type        = string
  description = "(Use environment variable PM_API_TOKEN_SECRET) This uuid is only available when the token was initially created."
}

variable "pm_tls_insecure" {
  type        = bool
  description = "Disable TLS verification while connecting to the proxmox server."
  default     = true
}

variable "pm_log_enable" {
  type        = bool
  description = "Enable debug logging, see the section below for logging details."
  default     = false
}

variable "pm_log_file" {
  type        = string
  description = "If logging is enabled, the log file the provider will write logs to."
  default     = "terraform-plugin-proxmox.log"
}

variable "pm_debug" {
  type        = bool
  description = "Enable verbose output in proxmox-api-go."
  default     = false
}

variable "pm_log_levels_default" {
  type        = string
  description = "A map of log sources and levels. (_default)"
  default     = "debug"
}

variable "pm_log_levels_capturelog" {
  type        = string
  description = "A map of log sources and levels. (_capturelog)"
  default     = ""
}

# Provisioner Cloud-Init File
variable "connection_type" {
  type        = string
  description = "The connection type. Valid values are `ssh` and `winrm`. Provisioners typically assume that the remote system runs Microsoft Windows when using WinRM. Behaviors based on the SSH target_platform will force Windows-specific behavior for WinRM, unless otherwise specified."
}

variable "connection_user" {
  type        = string
  description = "The user to use for the connection."
}

variable "connection_private_key_path" {
  type        = string
  description = "The contents of an SSH key to use for the connection. These can be loaded from a file on disk using the file function. This takes preference over password if provided."
}

variable "connection_host" {
  type        = string
  description = "The address of the pve host to connect to."
}

variable "provisioner_directory_path" {
  type        = string
  description = "The directory path (without the filename) used by the provisioner."
  default     = "/var/lib/vz/snippets"
}
