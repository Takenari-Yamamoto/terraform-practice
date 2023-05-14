variable "project_id" {
  description = "golang-project-377611"
  default     = "golang-project-377611"
  type        = string
}

variable "region" {
  description = "The region where resources will be managed."
  type        = string
  default     = "us-central1"
}

variable "network_self_link" {
  description = "The self link of the network where the Cloud SQL instance will be created"
  type        = string
}
