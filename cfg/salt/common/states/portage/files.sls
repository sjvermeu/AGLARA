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

/etc/portage/package.accept_keywords/salt:
  file.managed:
    - source: salt://portage/package.accept_keywords_salt
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/etc/portage/repos.conf:
  file.managed:
    - source: salt://portage/repos.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
