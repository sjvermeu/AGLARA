/etc/dhcpcd.conf:
  file.managed:
    - source: salt://dhcpcd/dhcpcd.conf
    - user: root
    - group: root
    - mode: 644
