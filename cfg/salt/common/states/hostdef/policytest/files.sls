/root/.muttrc:
  file.managed:
    - source: salt://hostdef/policytest/muttrc
    - user: root
    - group: root
    - mode: 644

restorecon-/root/.muttrc:
  cmd:
    - wait
    - name: "restorecon -v /root/.muttrc"
    - watch:
      - file: /root/.muttrc

/etc/salt/grains:
  file.managed:
    - source: salt://hostdef/policytest/salt-grains
    - user: root
    - group: root
    - mode: 644

/etc/portage/package.accept_keywords/selinux:
  file.managed:
    - source: salt://hostdef/policytest/package.accept_keywords.selinux
    - user: root
    - group: root
    - mode: 644
