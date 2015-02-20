/etc/portage/make.conf:
  file.managed:
    - source: salt://portage/make.conf
    - user: root
    - group: root
    - mode: 644

/etc/portage/package.use/mutt:
  file.managed:
    - source: salt://portage/package.use_mutt
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
