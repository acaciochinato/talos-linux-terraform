variable "endpoint" {
  type        = string
  description = "Base URL for the Proxmox API Endpoint. Ex: https://pve.example.com"
}

variable "api_token" {
  type        = string
  description = "API credentials for authentication. See https://registry.terraform.io/providers/bpg/proxmox/latest/docs#api-token-authentication"
}

variable "username" {
  type        = string
  description = "Username to authenticate via SSH"
}

variable "ssh_key_file_path" {
  type        = string
  description = "Full path of the SSH key for the sudo privileged user for authentication"
}