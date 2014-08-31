/srv/salt:
  mount.mounted:
    - device: workstation4:/srv/virt/nfs/gentoo/salt
    - fstype: nfs4
    - mkmnt: True
    - persist: True
    - opts:
      - defaults

include:
  - hostdef.salt.files
