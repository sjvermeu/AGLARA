/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/main-server.cf
    - user: root
    - group: root
    - mode: 644
