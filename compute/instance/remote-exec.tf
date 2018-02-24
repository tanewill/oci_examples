resource "null_resource" "remote-exec" {
    depends_on = ["oci_core_instance.TFInstance","oci_core_volume_attachment.TFBlock0Attach"]
    provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "30m"
        host = "${data.oci_core_vnic.InstanceVnic.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "touch ~/IMadeAFile.Right.Here",
        "wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
        "sudo rpm -ivh epel-release-latest-7.noarch.rpm",
        "sudo yum repolist",
        "sudo yum check-update",
        "sudo yum install -y -q pdsh stress axel fontconfig freetype freetype-devel fontconfig-devel libstdc++ libXext libXt libXrender-devel.x86_64 libXrender.x86_64 mesa-libGL.x86_64 openmpi screen",
        "sudo yum install -y -q nfs-utils sshpass nmap htop pdsh screen git psmisc",
        "sudo yum install -y -q gcc libffi-devel python-devel openssl-devel",
        "git clone https://github.com/oci-hpc/oci-hpc-ref-arch",
        "sudo iscsiadm -m node -o new -T ${oci_core_volume_attachment.TFBlock0Attach.iqn} -p ${oci_core_volume_attachment.TFBlock0Attach.ipv4}:${oci_core_volume_attachment.TFBlock0Attach.port}",
        "sudo iscsiadm -m node -o update -T ${oci_core_volume_attachment.TFBlock0Attach.iqn} -n node.startup -v automatic",
        "echo sudo iscsiadm -m node -T ${oci_core_volume_attachment.TFBlock0Attach.iqn} -p ${oci_core_volume_attachment.TFBlock0Attach.ipv4}:${oci_core_volume_attachment.TFBlock0Attach.port} -l >> ~/.bashrc",
        "sudo yum install -y parted",
        "sudo parted /dev/sdb mklabel gpt",
        "sudo parted -a opt /dev/sdb mkpart primary ext4 0% 100%",
        "sudo mkfs.ext4 -L datapartition /dev/sdb1",
        "sudo mkdir -p /mnt/blk",
        "sudo mount -o defaults /dev/sdb1 /mnt/blk"
      ]
    }
}

