/var/portage:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/var/portage/packages:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/var/portage/distfiles:
  file.directory:
    - user: portage
    - group: portage
    - mode: 755
    - makedirs: True

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

/etc/portage/package.accept_keywords/salt:
  file.managed:
    - source: salt://portage/package.accept_keywords_salt
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
