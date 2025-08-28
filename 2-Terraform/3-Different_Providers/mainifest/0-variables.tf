variable "project_id-1" {
      description = "The GCP project ID."
      type        = string

}

variable "project_id-2" {
      description = "The GCP project ID."
      type        = string
}

variable "region" {
      description = "The GCP region for resources."
      type        = string
      default     = "us-central1"
}

variable "zone" {
      description = "The GCP zone for resources."
      type        = string
      default     = "us-central1-a"
}

