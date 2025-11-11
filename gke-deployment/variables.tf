variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for GKE"
  type        = string
  default     = "asia-south1"
}
