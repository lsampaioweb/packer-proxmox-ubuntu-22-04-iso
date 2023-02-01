variable "disks" {
  description = "Hard Disks for the VM."
  type = map(object({
    # The type of disk. Can be scsi, sata, virtio or ide. Defaults to scsi.
    type = string
    # Required. Name of the Proxmox storage pool to store the virtual machine disk on.
    storage_pool = string
    # Required. The type of the pool. Can be lvm, lvm-thin, zfspool, cephfs, rbd or directory.
    storage_pool_type = string
    # The size of the disk, including a unit suffix, such as 10G to indicate 10 gigabytes.
    size = string
    # How to cache operations to the disk. Can be none, writethrough, writeback, unsafe or directsync. Defaults to none.
    cache_mode = string
    # The format of the file backing the disk. Can be raw, cow, qcow, qed, qcow2, vmdk or cloop. Defaults to raw.
    format = string
    # Create one I/O thread per storage controller, rather than a single thread for all I/O. This can increase performance when multiple disks are used. Requires virtio-scsi-single controller and a scsi or virtio disk. Defaults to false.
    io_thread = bool
  }))

  default = {
    "0" = {
      type              = "scsi"
      storage_pool      = "Ceph_Silver"
      storage_pool_type = "lvm"
      size              = "20G"
      cache_mode        = "none"
      format            = "raw"
      io_thread         = true
    }
  }
}
