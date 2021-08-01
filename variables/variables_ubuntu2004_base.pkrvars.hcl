#iso_url="https://ftp.icm.edu.pl/pub/Linux/ubuntu-releases/20.04.2.0/ubuntu-20.04.2-live-server-amd64.iso"
iso_url="../ISO/ubuntu-20.04.2-live-server-amd64.iso"
iso_checksum_type="sha256"
iso_checksum="d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"
vm_name="packer-ubuntu2004-g2"
configuration_version="8.0"
disk_size="70000"
disk_additional_size=["150000"]
switch_name="Internal Switch"
output_directory="output-ubuntu2004-base"
output_vagrant="../vbox/packer-ubuntu2004-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/hv_ubuntu2004_g2.template"
provision_script_options="-p false -h false -z false"
boot_command=[
  "<esc><esc><esc><wait>",
  "set gfxpayload=1024x768<enter>",
  "linux /casper/vmlinuz ",
  "autoinstall \"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" ",
  "hostname={{.Name}} ",
  "boot=casper fsck.mode=skip auto=true noprompt noeject",
  "<enter>",
  "initrd /casper/initrd<enter>",
  "boot<enter>"
]
ansible_override = "variables/ubuntu2004.yml"
