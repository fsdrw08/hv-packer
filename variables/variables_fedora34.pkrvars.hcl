#iso_url="https://download.fedoraproject.org/pub/fedora/linux/releases/34/Server/x86_64/iso/Fedora-Server-dvd-x86_64-34-1.2.iso"
iso_url="../ISO/Fedora-Server-dvd-x86_64-34-1.2.iso"
iso_checksum_type="sha256"
iso_checksum="0B9DC87D060C7C4EF89F63DB6D4D1597DD3FEAF4D635CA051D87F5E8C89E8675"
vm_name="packer-fedora-g2"
configuration_version="8.0"
disk_size="70000"
disk_additional_size=["150000"]
switch_name="Internal Switch"
output_directory="output-fedora-base"
output_vagrant="../vbox/packer-fedora34-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/hv_fedora_g2.template"
boot_command=[
  "c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=Fedora-S-dvd-x86\\_64-34 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-fedora.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"
]
