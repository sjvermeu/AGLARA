/etc/portage/make.conf:
  file.managed:
    - source: salt://portage/make.conf
    - user: root
    - group: root
    - mode: 644
