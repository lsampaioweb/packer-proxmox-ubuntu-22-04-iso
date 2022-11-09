variable "disk_type" {
  description = "The type of disk. Can be scsi, sata, virtio or ide. Defaults to scsi."
  type        = string
  default     = "scsi"
}

variable "disk_storage_pool" {
  description = "Required. Name of the Proxmox storage pool to store the virtual machine disk on."
  type        = string
  default     = "Ceph_Silver"
}

variable "disk_storage_pool_type" {
  description = "Required. The type of the pool. Can be lvm, lvm-thin, zfspool, cephfs, rbd or directory."
  type        = string
  default     = "lvm"
}

variable "disk_disk_size" {
  description = "The size of the disk, including a unit suffix, such as 10G to indicate 10 gigabytes."
  type        = string
  default     = "20G"
}

variable "disk_cache_mode" {
  description = "How to cache operations to the disk. Can be none, writethrough, writeback, unsafe or directsync. Defaults to none."
  type        = string
  default     = "none"
}

variable "disk_format" {
  description = "The format of the file backing the disk. Can be raw, cow, qcow, qed, qcow2, vmdk or cloop. Defaults to raw."
  type        = string
  default     = "raw"
}

variable "disk_io_thread" {
  description = "Create one I/O thread per storage controller, rather than a single thread for all I/O. This can increase performance when multiple disks are used. Requires virtio-scsi-single controller and a scsi or virtio disk. Defaults to false."
  type        = bool
  default     = true
}
