#iso_url="https://dl-cdn.alpinelinux.org/alpine/v3.14/releases/x86_64/alpine-virt-3.14.2-x86_64.iso"
#iso_url="../ISO/alpine-standard-3.14.0-x86_64.iso"
iso_url="../ISO/alpine-virt-3.14.2-x86_64.iso"
iso_checksum_type="sha256"
#iso_checksum="4bf69f1d96384bd88574e6c64583f40d3c6ae07af4c96772900492ba0f0b9126"
iso_checksum="FCBA6ECC8419DA955D326A12B2F6D9D8F885A420A1112E0CF1910914C4C814A7"
vm_name="packer-alpine314-g2"
configuration_version="8.0"
disk_size="70000"
switch_name="Internal Switch"
output_directory="output-alpine314-base"
output_vagrant="../vbox/packer-alpine314-base-hv-g2.box"
vlan_id=""
vagrantfile_template="./vagrant/hv_alpine_g2.template"
alpine_version="3.14"
mirror="https://mirrors.tuna.tsinghua.edu.cn/alpine/"
boot_command=["root<enter><wait>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
    "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>",
    "setup-alpine -f answers<enter><wait5>",
    "root<enter><wait>",
    "root<enter><wait20>",
    "y<enter><wait40>",
    "rc-service sshd stop<enter>",
    "mount /dev/sda3 /mnt<enter>",
    "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter>",
    "umount /mnt<enter>",
    "reboot<enter><wait20>",
    "root<enter>",
    "root<enter><wait5>",
    "apk add hvtools dhclient<enter><wait10>",
    "rc-update add hv_fcopy_daemon<enter><wait>",
    "rc-update add hv_kvp_daemon<enter><wait>",
    "rc-update add hv_vss_daemon<enter><wait>",
    "rc-service hv_fcopy_daemon start<enter><wait>",
    "rc-service hv_kvp_daemon start<enter><wait>",
    "rc-service hv_vss_daemon start<enter><wait>",
    "exit<enter>"
]