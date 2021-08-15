#iso_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.0.0-amd64-netinst.iso"
iso_url="../ISO/debian-11.0.0-amd64-netinst.iso"
iso_checksum_type="sha256"
iso_checksum="ae6d563d2444665316901fe7091059ac34b8f67ba30f9159f7cef7d2fdc5bf8a"
vm_name="packer-debian11-g2"
configuration_version="8.0"
disk_size="70000"
disk_additional_size=["150000"]
switch_name="Internal Switch"
output_directory="output-debian11-base"
output_vagrant="../vbox/packer-debian11-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/hv_debian11_g2.template"
boot_command=[
  "c<wait>",
  "linux /install.amd/vmlinuz",
  " auto=true",
  " url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
  " hostname=debian11",
  " domain=lab",
  "<enter>",
  "initrd /install.amd/initrd.gz<enter>",
  "boot<enter>"
]
ansible_override = "variables/ubuntu2004.yml"
