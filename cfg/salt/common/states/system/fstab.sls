/usr/portage-mnt:
  mount.mounted:
    - name: /usr/portage
    - device: workstation4:/usr/portage
    - fstype: nfs4
    - mkmnt: True
    - persist: True
    - opts:
      - vers=4.0
      - defaults

/var/portage/packages-mnt:
  mount.mounted:
    - name: /var/portage/packages
    - device: workstation4:/srv/virt/nfs/gentoo/packages
    - fstype: nfs4
    - mkmnt: True
    - persist: True
    - opts:
      - vers=4.0
      - defaults
