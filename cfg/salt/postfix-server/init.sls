mail-mta/postfix:
  pkg:
    - installed
  service:
    - name: "postfix"
    - running

/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix-server/main.cf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: mail-mta/postfix

postfix-reload:
  cmd:
    - wait
    - name: "postfix reload"
    - watch:
      - file: /etc/postfix/main.cf

/etc/portage/package.use/postfix:
  file.managed:
    - source: salt://postfix-server/package.use
    - user: root
    - group: root
    - mode: 644
