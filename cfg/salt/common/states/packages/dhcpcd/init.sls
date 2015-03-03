/etc/dhcpcd.conf:
  file.managed:
    - source: salt://packages/dhcpcd/dhcpcd.conf
    - user: root
    - group: root
    - mode: 644
