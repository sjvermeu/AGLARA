base:
  '*':
    - users
    - portage
    - hosts
    - dhcpcd
  'salt.internal.genfic.local':
    - salt
  'mail.internal.genfic.local':
    - postfix
