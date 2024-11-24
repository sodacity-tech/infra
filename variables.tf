#region TF_VAR_* environment variables
variable "vm_ssh_key" {
  description = "Public part of an SSH keypair to associate with provisioned compute"
  type        = string
  nullable    = false
}

variable "hcloud_api_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
  nullable    = false
}
#endregion

#region other variables
variable "org_name" {
  description = "Used as common prefix for all resources where applicable"
  type        = string
  default     = "sodacity"
}

variable "hcloud_location" {
  description = "Hetzner Datacenter to spin up Hetzner Servers in"
  type        = string
  default     = "ash"
}

variable "hcloud_num_vms" {
  description = "Number of Hetzner Servers to launch"
  type        = number
  default     = 3
}
#endregion
