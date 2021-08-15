#iso_url="https://ftp.icm.edu.pl/pub/Linux/ubuntu-releases/20.04.2.0/ubuntu-20.04.2-live-server-amd64.iso"
iso_url="../ISO/openSUSE-Tumbleweed-DVD-x86_64-Snapshot20210810-Media.iso"
iso_checksum_type="sha256"
iso_checksum="a89636a2776cf6bf34130c6ccb732752dce7208e18361aba0a67812c7ad361ec"
vm_name="packer-opensuse-tumbleweed-g2"
configuration_version="8.0"
disk_size="70000"
disk_additional_size=["150000"]
switch_name="Internal Switch"
output_directory="output-opensuse-tumbleweed-base"
output_vagrant="../vbox/packer-opensuse-tumbleweed-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/hv_opensuse-tumbleweed_g2.template"
boot_command=[
  "c<wait>",
  "linux ",
  "biosdevname=0 ",
  "net.ifnames=0 ",
  "netdevice=eth0 ",
  "netsetup=dhcp ",
  "lang=en_US ",
  "textmode=1 ",
  "autoyast=http://{{.HTTPIP}}:{{.HTTPPort}}/tumbleweed-general.xml ",
  "<enter><wait>"
]
