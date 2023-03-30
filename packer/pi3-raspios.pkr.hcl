source "arm" "raspios" {
  file_urls             = ["https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2023-02-22/2023-02-21-raspios-bullseye-arm64-lite.img.xz"]
  file_checksum_url     = "https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2023-02-22/2023-02-21-raspios-bullseye-arm64-lite.img.xz.sha256"
  file_checksum_type    = "sha256"
  file_target_extension = "xz"
  file_unarchive_cmd    = ["xz", "--decompress", "$ARCHIVE_PATH"]

  image_partitions {
    name         = "boot"
    filesystem   = "vfat"
    mountpoint   = "/boot"
    size         = "256M"
    start_sector = 8192
    type         = "c"
  }

  image_partitions {
    name         = "root"
    filesystem   = "ext4"
    mountpoint   = "/"
    size         = 0
    start_sector = 532480
    type         = 83
  }

  image_path         = "pi3-raspios-arm64.img"
  image_size         = "2G"
  image_type         = "dos"
  image_build_method = "reuse"
  image_chroot_env   = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]

  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.raspios"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get upgrade",
      "touch /tmp/test",
      "echo 'test' > /tmp/test",
    ]
  }
}