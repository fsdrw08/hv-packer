variable "ansible_override" {
  type    = string
  default = ""
}

variable "alpine_version" {
  type    = string
}

variable "boot_command" {
  type    = list(string)
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
  boot_command          = "${var.boot_command}"
  boot_wait             = "10s"
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
  http_directory        = "./extra/files/gen2-alpine"
  iso_checksum          = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url               = "${var.iso_url}"
  memory                = "${var.memory}"
  output_directory      = "${var.output_directory}"
  shutdown_command      = "poweroff"
  shutdown_timeout      = "30m"
  ssh_password          = "root"
  ssh_timeout           = "4h"
  ssh_username          = "root"
  switch_name           = "${var.switch_name}"
  temp_path             = "."
  vlan_id               = "${var.vlan_id}"
  vm_name               = "${var.vm_name}"
}

build {
  sources = ["source.hyperv-iso.vm"]

  provisioner "shell" {
      // "echo ${var.mirror}v${var.alpine_version}/community >> /etc/apk/repositories",
      // "echo ${var.mirror}edge/testing >> /etc/apk/repositories",
    inline          = [
      "apk update",
      "apk add sudo",
      "echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel",
      "user=${var.ssh_username}",
      "group=${var.ssh_username}",
      "echo Add group $group for user $user",
      "addgroup $group",
      "echo Add user $user with NOPASSWD sudo",
      "adduser $user --ingroup $group --disabled-password",
      "echo '${var.ssh_username}:${var.ssh_password}' | chpasswd",
      "adduser $user wheel",
      "echo add ssh key",
      "cd ~${var.ssh_username}",
      "mkdir .ssh",
      "chmod 700 .ssh",
      "echo ${var.ssh_key} > .ssh/authorized_keys",
      "chown -R $user .ssh",
      "echo install rsync",
      "apk add rsync",
      "echo disable ssh root login",
      "sed '/PermitRootLogin yes/d' -i /etc/ssh/sshd_config"
    ]
  }

  post-processor "vagrant" {
    keep_input_artifact  = true
    output               = "${var.output_vagrant}"
    vagrantfile_template = "${var.vagrantfile_template}"
  }
}
