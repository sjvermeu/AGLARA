/root/.bash_profile:
  file.managed:
    - source: salt://system/00-PS1-with-rc.sh
    - user: root
    - group: root
    - mode: 644

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
