/srv/salt:
  mount.mounted:
    - device: workstation4:salt
    - fstype: nfs4
    - mkmnt: True
    - persist: True
    - opts:
      - defaults
