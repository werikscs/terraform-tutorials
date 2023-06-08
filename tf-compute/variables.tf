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

variable "ssh_public_key_path" {
  description = "Path to SSH public key file"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key file"
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

variable "subnet_ocid" {
  description = "OCI subnet OCID"
  type        = string
}

variable "source_ocid" {
  description = "OCI source OCID"
  type        = string
}

variable "docker_username" {
  description = "Username for Docker Hub"
  type        = string
}

variable "docker_password" {
  description = "Password for Docker Hub"
  type        = string
}

variable "image_name" {
  description = "Image name on Docker Hub"
  type        = string
}

variable "image_tag_name" {
  description = "Image tag name on Docker Hub"
  type        = string
}

variable "instance_port" {
  description = "Instance port"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = string
}

variable "noip_hostname" {
  description = "No-IP hostname"
  type        = string
}

variable "noip_username" {
  description = "No-IP username"
  type        = string
}

variable "noip_password" {
  description = "No-IP password"
  type        = string
}

