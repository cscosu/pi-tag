
source "arm" "ubuntu" {
  file_urls             = ["https://cdimage.ubuntu.com/ubuntu/releases/22.04/release/ubuntu-22.04.2-preinstalled-server-arm64+raspi.img.xz"]
  file_checksum_url     = "https://cdimage.ubuntu.com/ubuntu/releases/22.04/release/SHA256SUMS"
  file_checksum_type    = "sha256"
  file_target_extension = "xz"
  file_unarchive_cmd    = ["xz", "--decompress", "$ARCHIVE_PATH"]

  image_partitions {
    name         = "boot"
    filesystem   = "vfat"
    mountpoint   = "/boot"
    size         = "256M"
    start_sector = "2048"
    type         = "c"
  }

  image_partitions {
    name         = "root"
    filesystem   = "ext4"
    mountpoint   = "/"
    size         = "0"
    start_sector = "526336"
    type         = "83"
  }

  image_path         = "pi3-ubuntu-arm64.img"
  image_size         = "2G"
  image_type         = "dos"
  image_build_method = "reuse"
  image_chroot_env   = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]

  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.ubuntu"]

  provisioner "shell" {
    inline = [
      "hostname tag",
      "useradd -m tag",
      "usermod -aG sudo tag",
      "echo tag:tag | chpasswd",
      "echo root:root | chpasswd",
      "apt-get update",
      "DEBIAN_FRONTEND=noninteractive apt-get upgrade -y",
      "DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4",
    ]
  }
}