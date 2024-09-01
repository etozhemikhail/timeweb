variable "twc_token" {
  description = "Token for Timeweb Cloud provider"
  type        = string
  sensitive   = true
}

variable "os_name" {
  description = "Operating System name"
  type        = string
  default     = "ubuntu"
}

variable "os_version" {
  description = "Operating System version"
  type        = string
  default     = "20.04"
}

variable "location" {
  description = "Location for configurator"
  type        = string
  default     = "kz-1"
}

variable "ssh_key_name" {
  description = "Name for SSH key"
  type        = string
  default     = "Your key"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "Jenkins Server"
}

variable "disk_size" {
  description = "Size of the disk in MB"
  type        = number
  default     = 51200
}

variable "cpu_count" {
  description = "Number of CPUs"
  type        = number
  default     = 2
}

variable "ram_size" {
  description = "Amount of RAM in MB"
  type        = number
  default     = 4096
}

variable "ssh_private_key_path" {
  description = "Path to the private SSH key file"
  type        = string
  default     = "~/.ssh/id_rsa"

}