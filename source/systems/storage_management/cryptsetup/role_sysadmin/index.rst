====================================
Cryptsetup for System Administrators
====================================

LUKS (Linux Unified Key Setup) uses a single encryption key, which is then
encrypted by one to eight keys (which can be used to "unlock" the encryption
key).

Encrypted storage
=================

Initial encrypted storage
-------------------------

To create an encrypted partition with a random 256 bit key (yes, 512 is
actually a 256 bit key to be used), the following command can be used. Note
that the passphrase that will be asked is to *unlock* that key::

  ~# cryptsetup -s 512 luksFormat /dev/vdb2 
  This will overwrite data on /dev/vdb2 irrevocably.

  Are you sure? (Type uppercase yes): YES
  Enter LUKS passphrase: ...
  Verify passphrase: ...

Instead of a passphrase, you can also use a keyfile (which contains random
data)::

  ~# cryptsetup -s 512 luksFormat /dev/vdb2 /etc/keys/keyfile.key
  This will overwrite data on /dev/vdb2 irrevocably.

  Are you sure? (Type uppercase yes): YES

Unlocking (opening) the encrypted storage
-----------------------------------------

To access the storage, use the ``luksOpen`` instruction::

  ~# cryptsetup luksOpen /dev/vdb2 crTest
  Enter passphrase for /dev/vdb2: ...

If a keyfile is used::

  ~# cryptsetup luksOpen -d /etc/keys/keyfile.key /dev/vdb2 crTest

Now a device will be made available in ``/dev/mapper`` named ``crTest``.

If this device hosts an LVM volume, the volume group can now be activated::

  ~# vgchange -a y
  1 logical volume(s) in volume group "vgtest" now active

Locking (closing) the encrypted storage
---------------------------------------

To close (lock) the storage again, make sure it is no longer in use. For
instance, with LVM being used::

  ~# vgs
  VG     #PV #LV #SN Attr   VSize VFree
  vgtest   1   1   0 wz--n- 4.00g 3.00g
  
  ~# vgchange -a n vgtest
  0 logical volume(s) in volume group "vgtest" now active

Now the encrypted container can be closed::

  ~# cryptsetup luksClose crTest

Key handling
============

The encrypted container can hold up to 8 keys which can be used to decrypt the
master key (and as such unlocking/opening the encrypted storage). Each slot can
be used for either a passphrase or keyfile.

Listing slots
-------------

With the ``luksDump`` command, information about the LUKS header is displayed.
This is public information (so no passphrase is needed)::

  ~# cryptsetup luksDump /dev/vdb2
  LUKS header information for /dev/vdb2

  Version:        1
  Cipher name:    aes
  Cipher mode:    xts-plain64
  Hash spec:      sha1
  Payload offset: 4096
  MK bits:        512
  MK digest:      34 3b ec ac 10 af 19 e7 e2 d4 c8 90 eb a8 da 3c e4 4f 2e ce 
  MK salt:        ff 7c 7f 53 db 53 48 02 a4 32 dc e0 22 fc a3 51 
                  06 ba b3 48 b3 28 13 a8 7a 68 43 d6 46 79 14 fe 
  MK iterations:  59375
  UUID:           2921a7c9-7ccb-4300-92f4-38160804e08c

  Key Slot 0: ENABLED
          Iterations:             241053
          Salt:                   90 0f 0f db cf 66 ea a9 6c 7c 0c 0d b0 28 05 2f
                                  8a 5c 14 54 98 62 1a 29 f3 08 25 0c ec c2 b1 68
          Key material offset:    8
          AF stripes:             4000
  Key Slot 1: ENABLED
          Iterations:             273211
          Salt:                   01 4c 26 ed ff 18 75 31 b9 89 5d a6 e0 b5 f4 14 
                                  48 d0 23 47 a9 85 78 fb 76 c4 a9 d0 cd 63 fb d7
          Key material offset:    512
          AF stripes:             4000
  Key Slot 2: DISABLED
  Key Slot 3: DISABLED
  Key Slot 4: DISABLED
  Key Slot 5: DISABLED
  Key Slot 6: DISABLED
  Key Slot 7: DISABLED

Adding a keyfile or passphrase
------------------------------

With ``luksAddKey`` additional passphrases or keyfiles can be added.

To add a passphrase::

  ~# cryptsetup luksAddKey /dev/vdb2

To add a keyfile::

  ~# cryptsetup luksAddKey /dev/vdb2 /etc/keys/somekeyfile.key

Removing a keyfile or passphrase
--------------------------------

Either pass the keyfile, or the passphrase which needs to be removed.

With a passphrase::

  ~# cryptsetup luksRemoveKey /dev/vdb2
  Enter passphrase to be deleted: ...

With a keyfile::

  ~# cryptsetup luksRemoveKey /dev/vdb2 /etc/keys/somekeyfile.key

Killing a slot
--------------

If the passphrase is no longer known, or the key has been lost, the slot can
be freed. For instance, to free slot number 2 (3rd slot)::

  ~# cryptsetup luksKillSlot /dev/vdb2 2

Either a passphase for another slot is to be given, or a key file::

  ~# cryptsetup luksKillSlot -d /etc/keys/somekeyfile.key /dev/vdb2 2

Header
======

If the header is lost, then the partition cannot be recovered. Some people
would like to keep a backup of this header just in case.

Backup the LUKS header
----------------------

To backup the LUKS header::

  ~# cryptsetup luksHeaderBackup /dev/vdb2 --header-backup-file /run/lukshdr.img



