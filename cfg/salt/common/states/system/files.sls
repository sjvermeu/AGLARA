/root/.bash_profile:
  file.managed:
    - source: salt://system/root-profile
    - user: root
    - group: root
    - mode: 644

/root/.ssh/authorized_keys:
  file.managed:
    - source: salt://system/root-authorized_keys
    - user: root
    - group: root
    - mode: 600

/root/.vimrc:
  file.managed:
    - source: salt://system/vimrc
    - user: root
    - group: root
    - mode: 644

/etc/pam.d/run_init:
  file.managed:
  - source: salt://system/run_init
  - user: root
  - group: root
  - mode: 644

/etc/locale.gen:
  file.managed:
  - source: salt://system/locale.gen
  - user: root
  - group: root
  - mode: 644
