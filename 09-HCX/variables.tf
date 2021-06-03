variable "hcx_admin_username" {
  type        = string
  description = "Username for on-prem HCX appliance management"
  default     = "admin"
}

variable "hcx_admin_password" {
  type        = string
  description = "Password for on-prem HCX appliance management"
  sensitive   = true
}

variable "hcx_username" {
  type        = string
  description = "Username for on-prem HCX"
}

variable "hcx_password" {
  type        = string
  description = "Password for on-prem HCX"
  sensitive   = true
}

variable "cloud_hcx_username" {
  type        = string
  description = "Username for cloud side HCX"
}

variable "cloud_hcx_password" {
  type        = string
  description = "Password for cloud side HCX"
  sensitive   = true
}