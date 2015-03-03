/root/.muttrc:
  file.managed:
    - source: salt://hostdef/salt/muttrc
    - user: root
    - group: root
    - mode: 644

restorecon-/root/.muttrc:
  cmd:
    - wait
    - name: "restorecon -v /root/.muttrc"
    - watch:
      - file: /root/.muttrc

/etc/salt/master:
  file.managed:
    - source: salt://hostdef/salt/salt-master
    - user: root
    - group: root
    - mode: 644

/etc/salt/minion:
  file.managed:
    - source: salt://hostdef/salt/salt-minion
    - user: root
    - group: root
    - mode: 644

/etc/salt/grains:
  file.managed:
    - source: salt://hostdef/salt/salt-grains
    - user: root
    - group: root
    - mode: 644
