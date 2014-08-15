/usr/portage-mnt:
  mount.mounted:
    - name: /usr/portage
    - device: workstation4:gentoo/portage
    - fstype: nfs4
    - mkmnt: True
    - persist: True
    - opts:
      - defaults

/var/portage/packages-mnt:
  mount.mounted:
    - name: /var/portage/packages
    - device: workstation4:gentoo/packages
    - fstype: nfs4
    - mkmnt: True
    - persist: True
    - opts:
      - defaults
