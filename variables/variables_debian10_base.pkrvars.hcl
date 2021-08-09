#iso_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-10.10.0-amd64-DVD-1.iso"
iso_url="../ISO/debian-10.10.0-amd64-DVD-1.iso"
iso_checksum_type="sha256"
iso_checksum="f8449b103c9fe9a4a80004d19046a4220b25dfaa532825f9f86a4d6b42dfa7f4"
vm_name="packer-debian10-g2"
configuration_version="8.0"
disk_size="70000"
disk_additional_size=["150000"]
switch_name="Internal Switch"
output_directory="output-debian10-base"
output_vagrant="../vbox/packer-debian10-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/debian10.template"
boot_command=[
  "<esc><wait>",
  "install <wait>",
  " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
  "debian-installer=en_US.UTF-8 <wait>",
  "auto <wait>",
  "locale=en_US.UTF-8 <wait>",
  "kbd-chooser/method=us <wait>",
  "keyboard-configuration/xkb-keymap=us <wait>",
  "netcfg/get_hostname={{ .Name }} <wait>",
  "netcfg/get_domain=vagrantup.com <wait>",
  "fb=false <wait>",
  "debconf/frontend=noninteractive <wait>",
  "console-setup/ask_detect=false <wait>",
  "console-keymaps-at/keymap=us <wait>",
  "grub-installer/bootdev=/dev/sda <wait>",
  "<enter><wait>"
]
ansible_override = "variables/ubuntu2004.yml"
