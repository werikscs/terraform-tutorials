variable "tenancy_ocid" {
  description = "OCI tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "OCI user OCID"
  type        = string
}

variable "private_key_path" {
  description = "Path to OCI private key file"
  type        = string
}

variable "fingerprint" {
  description = "OCI user fingerprint"
  type        = string
}

variable "region" {
  description = "OCI region"
  type        = string
}

variable "compartment_id" {
  description = "OCI compartment OCID"
  type        = string
}
