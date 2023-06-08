resource "oci_core_instance" "ubuntu_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id      = var.compartment_id

  # MICRO
  shape = "VM.Standard.E2.1.Micro"

  # # FLEX
  # shape = "VM.Standard.A1.Flex"
  # shape_config {
  #   memory_in_gbs = "6"
  #   ocpus         = "2"
  # }

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

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      "echo ${var.docker_password} | sudo docker login --username ${var.docker_username} --password-stdin",
      "sudo docker run -d -p ${var.instance_port}:${var.container_port} --name api ${var.docker_username}/${var.image_name}:${var.image_tag_name}",
    ]
    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }
}

# Atualiza o registro DNS no No-IP com o IP da instância OCI
resource "null_resource" "update_noip_dns" {
  depends_on = [oci_core_instance.ubuntu_instance]

  provisioner "local-exec" {
    command = <<-EOT
      curl -k -u "${var.noip_username}:${var.noip_password}" "http://dynupdate.no-ip.com/nic/update?hostname=${var.noip_hostname}&myip=${oci_core_instance.ubuntu_instance.public_ip}"
    EOT
  }
}
