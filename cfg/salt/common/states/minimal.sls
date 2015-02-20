include:
  - users
  - hosts
  - dhcpcd
  - system
  - kernel
  - portage
  # Include host-specific settings. Use the nodename grain to identify which to load.
  - hostdef.{{ salt['grains.get']('nodename') }}
