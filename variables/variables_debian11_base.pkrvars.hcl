#iso_url="https://gemmei.ftp.acc.umu.se/debian-cd/current-live/amd64/iso-hybrid/debian-live-11.0.0-amd64-standard.iso"
iso_url="../ISO/debian-live-11.0.0-amd64-standard.iso"
iso_checksum_type="sha256"
iso_checksum="52f345a7dba199bf69cef818f2405485cfc913f714386b4de55ea7b3f7d6e6ce"
vm_name="packer-debian11-g2"
configuration_version="8.0"
disk_size="70000"
disk_additional_size=["150000"]
switch_name="Internal Switch"
output_directory="output-debian11-base"
output_vagrant="../vbox/packer-debian11-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/debian11.template"
boot_command=[
  "e<down><down><down><end>",
  "priority=critical auto=true preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
]
ansible_override = "variables/ubuntu2004.yml"
