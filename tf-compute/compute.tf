resource "oci_core_instance" "ubuntu_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id      = var.compartment_id

  shape = "VM.Standard.E2.1.Micro"

  source_details {
    source_id   = var.source_ocid
    source_type = "image"
  }

  display_name = "ubuntu_tutorial"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.subnet_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  preserve_boot_volume = false

  provisioner "remote-exec" {
    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }

    inline = ["[CONNECTED!]"]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' --user ubuntu --private-key ${var.ssh_private_key_path} ../ansible/playbook.yml"

    environment = {
      DOCKER_USERNAME       = var.docker_username
      DOCKER_PASSWORD       = var.docker_password
      DOCKER_IMAGE_NAME     = var.image_name
      DOCKER_IMAGE_TAG_NAME = var.image_tag_name
      INSTANCE_PORT         = var.instance_port
      CONTAINER_PORT        = var.container_port
    }
  }
}

resource "null_resource" "update_noip_dns" {
  depends_on = [oci_core_instance.ubuntu_instance]
  provisioner "local-exec" {
    command = <<-EOT
      curl -k -u "${var.noip_username}:${var.noip_password}" "http://dynupdate.no-ip.com/nic/update?hostname=${var.noip_hostname}&myip=${oci_core_instance.ubuntu_instance.public_ip}"
    EOT
  }
}
