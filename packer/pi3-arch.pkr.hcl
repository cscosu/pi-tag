source "arm" "arch" {
  file_urls             = ["http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz"]
  file_checksum_url     = "http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz.md5"
  file_checksum_type    = "md5"
  file_target_extension = "tar.gz"
  file_unarchive_cmd    = ["bsdtar", "-xpf", "$ARCHIVE_PATH", "-C", "$MOUNTPOINT"]

  image_partitions {
    filesystem   = "vfat"
    mountpoint   = "/boot"
    name         = "boot"
    size         = "256M"
    start_sector = "2048"
    type         = "c"
  }

  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "526336"
    type         = "83"
  }

  image_path         = "pi3-arch-arm64.img"
  image_size         = "2G"
  image_type         = "dos"
  image_build_method = "new"

  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.arch"]

  provisioner "shell" {
    inline = [
      "mv /etc/resolv.conf /etc/resolv.conf.bk",
      "echo 'nameserver 1.1.1.1' > /etc/resolv.conf",
      "pacman-key --init",
      "pacman-key --populate archlinuxarm",
      "pacman -Sy --noconfirm --needed",
      "pacman -S parted --noconfirm --needed"
    ]
  }
}