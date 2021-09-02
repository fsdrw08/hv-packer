#iso_url="https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/34.20210808.3.0/x86_64/fedora-coreos-34.20210808.3.0-live.x86_64.iso"
iso_url="../ISO/fedora-coreos-34.20210808.3.0-live.x86_64.iso"
iso_checksum_type="sha256"
iso_checksum="4774e25d4512ae5879b9d0e92ca629a8172b1e44501167d0d497ff27e352d4be"
vm_name="packer-coreos-g2"
configuration_version="8.0"
disk_size="70000"
disk_additional_size=["150000"]
switch_name="Internal Switch"
output_directory="output-coreos-base"
output_vagrant="../vbox/packer-coreos-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/hv_coreos_g2.template"
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
