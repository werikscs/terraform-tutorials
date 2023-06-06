

resource "oci_core_instance" "ubuntu_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.E2.1.Micro"

  source_details {
    source_id   = var.source_ocid
    source_type = "image"
  }

  # Optional
  display_name = "ubuntu_tutorial"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.subnet_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  preserve_boot_volume = false
}
