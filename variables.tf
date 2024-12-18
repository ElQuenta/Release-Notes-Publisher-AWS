variable "docdb_password" {
  description = "Password for Amazon DocumentDB"
  type        = string
  sensitive   = true
}

variable "docdb_user" {
  description = "DocumentDB user"
  type        = string
  sensitive = true
}

variable "docdb_port" {
  description = "DocumentDB port"
  type        = number
  default     = 64543
}

variable "NRP_core_token" {
  description = "Token for github runner"
  type = string
  sensitive = true
}

variable "NRP_web_token" {
  description = "Token for github runner"
  type = string
  sensitive = true
}