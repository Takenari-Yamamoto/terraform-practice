variable "project_id" {
  description = "The ID of the project in which the resources belong"
  type        = string
}

variable "region" {
  description = "The region in which to create the resources"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "The name of the network"
  type        = string
}

variable "vpc_connector_name" {
  description = "The name of the VPC connector"
  type        = string
}

variable "ip_cidr_range" {
  description = "The IP CIDR range"
  type        = string
  default     = "10.8.0.0/28"
}
