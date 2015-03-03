include:
  - users
  - system
  - kernel
  - portage
  - packages
  # Include host-specific settings. Use the nodename grain to identify which to load.
  - hostdef.{{ salt['grains.get']('nodename') }}
