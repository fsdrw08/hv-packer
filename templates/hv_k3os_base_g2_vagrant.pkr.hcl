variable "ansible_override" {
  type    = string
  default = ""
}

variable "configuration_version" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = string
  default = "70000"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "cpus" {
  type    = string
  default = "1"
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_checksum_type" {
  type    = string
  default = "none"
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "mirror" {
  type    = string
  default = "3.14"
}

variable "output_directory" {
  type    = string
  default = ""
}

variable "provision_script_options" {
  type    = string
  default = ""
}

variable "output_vagrant" {
  type    = string
  default = ""
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}
variable "ssh_password" {
  type    = string
  default = "vagrant"
}
variable "ssh_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "vagrantfile_template" {
  type    = string
  default = ""
}

variable "vlan_id" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

source "hyperv-iso" "vm" {
  boot_command          = [
    "rancher", "<enter><wait>",
    "sudo k3os install", "<enter><wait>",
    "1", "<enter><wait>",
    "y", "<enter><wait>",
    "http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.yml", "<enter><wait>",
    "y", "<enter>"
  ]
  boot_wait             = "40s"
  communicator          = "ssh"
  configuration_version = "${var.configuration_version}"
  cpus                  = "${var.cpus}"
  disk_block_size       = "1"
  disk_size             = "${var.disk_size}"
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  boot_order            = [
    "SCSI:0:0",
    "SCSI:0:1"
  ]
  generation            = 2
  guest_additions_mode  = "disable"
  http_directory        = "./extra/files/gen2-k3os"
  iso_checksum          = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url               = "${var.iso_url}"
  memory                = "${var.memory}"
  output_directory      = "${var.output_directory}"
  shutdown_command      = "sudo poweroff"
  shutdown_timeout      = "30m"
  ssh_password          = "root"
  ssh_timeout           = "4h"
  ssh_username          = "rancher"
  ssh_private_key_file  = "./extra/files/gen2-k3os/packer_rsa"
  switch_name           = "${var.switch_name}"
  temp_path             = "."
  vlan_id               = "${var.vlan_id}"
  vm_name               = "${var.vm_name}"
}

build {
  sources = ["source.hyperv-iso.vm"]

  post-processor "vagrant" {
    keep_input_artifact  = true
    output               = "${var.output_vagrant}"
    vagrantfile_template = "${var.vagrantfile_template}"
  }
}
