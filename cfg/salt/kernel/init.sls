/root/kernel-pkg.tar.bz2:
  file.managed:
    - source: salt://kernel/linux-3.15.10-hardened-r1-x86.tar.bz2
    - user: root
    - group: root
    - mode: 644

/usr/local/bin/install-kernel.sh:
  file.managed:
    - source: salt://kernel/install-kernel.sh
    - user: root
    - group: root
    - mode: 755

install-kernel:
  cmd:
    - wait
    - name: "/usr/local/bin/install-kernel.sh"
    - cwd: /tmp
    - watch:
      - file: /root/kernel-pkg.tar.bz2
