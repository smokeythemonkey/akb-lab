variable "pm_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
  default     = "https://192.168.178.46:8006/api2/json"
}

variable "pm_api_token_id" {
  description = "The ID of the Proxmox API token"
  type        = string
  default     = "akb@pam!terraform"
}

variable "pm_api_token_secret" {
  description = "The secret of the Proxmox API token"
  type        = string
  default     = "b7e167ba-0fce-4d3f-868e-2c04d0d62586"
}

variable "pm_host" {
  description = "The Proxmox host to deploy the VM on"
  type        = string
  default     = "pve"
}

variable "pm_vm_template" {
  description = "The Proxmox VM template to clone"
  type        = string
  default     = "ubuntu-2404-cloudinit-template"

}

variable "ssh_key" {
  description = "The SSH"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAU7gxORFDOTXKL5u49eQDfyjDjsoUZfupSkXxiSsWEW awollgarten@posteo.net"
}
