#!/bin/sh

FILE=linux-3.17.7-hardened-r1-x86.tar.bz2

TARGETFILE=/root/kernel-pkg.tar.bz2
VMLINUZ=$(echo ${FILE} | sed -e 's:linux-:vmlinuz-:g' -e 's:-x86.tar.bz2::g');

die() {
  echo "Awww man... $*";
  exit 1;
}

# Mount boot
test -d /boot/grub || mount /boot;
test -d /boot/grub || die "couldn't mount /boot"

# Unpack kernel
test -f ${TARGETFILE} || die "couldn't find the kernel image"
tar xvf ${TARGETFILE} --dereference --exclude "boot/vmlinux-*" -C /
test -f /boot/${VMLINUZ} || die "coulnd't find expected kernel image ${VMLINUZ}";

# Update grub
cd /tmp; # Needed because grub2-mkconfig requires access to its cdir for some weird reasons
grub2-mkconfig -o /boot/grub/grub.cfg || die "grub2-mkconfig failed"
test /boot/grub/grub.cfg -nt ${TARGETFILE} || die "grub.cfg file has not been changed"

exit 0;
