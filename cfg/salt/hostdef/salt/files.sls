mail-client/mutt:
  pkg:
    - installed

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
