base:
  '*':
    - users
    - portage
    - hosts
    - dhcpcd
    - system
  'salt.internal.genfic.local':
    - hostdef.salt
    - kernel
  'mail.internal.genfic.local':
    - postfix-server
    - hostdef.mail
  'minion.internal.genfic.local':
    - postfix-client
    - hostdef.minion
