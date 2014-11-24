base:
  '*':
    - users
    - portage
    - hosts
    - dhcpcd
    - system
    - kernel
  'salt.internal.genfic.local':
    - hostdef.salt
  'mail.internal.genfic.local':
    - postfix-server
    - hostdef.mail
  'minion.internal.genfic.local':
    - postfix-client
    - hostdef.minion
