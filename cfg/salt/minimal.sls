include:
  - users
  - portage
  - hosts
  - dhcpcd
  - system
  - kernel
  # Include host-specific settings. Use the nodename grain to identify which to load.
  - hostdef.{{ salt['grains.get']('nodename') }}
