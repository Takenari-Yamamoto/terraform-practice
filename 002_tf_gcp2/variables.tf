variable "project_id" {
  description = "golang-project-377611"
  type        = string
}

variable "region" {
  description = "The region of your resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone of your resources"
  type        = string
  default     = "us-central1-a"
}

variable "credentials" {
  description = "クレデンシャルやで"
  type        = string
  default     = "/Users/takenariyamamoto/dev/infra-practice/002_tf_gcp2/.config/gcp_credential.json"
}
