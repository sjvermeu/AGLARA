/srv/salt:
  mount.mounted:
    - device: workstation4:/srv/virt/nfs/gentoo/salt
    - fstype: nfs4
    - mkmnt: True
    - persist: True
    - opts:
      - nfsvers=4
      - defaults

include:
  - hostdef.salt.files
