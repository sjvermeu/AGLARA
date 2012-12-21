class general {
  ###############################
  #
  # General setup
  #

  # Manage /etc/hosts
  include hosts

  # Setup portage changes
  class {'portage':
    global_use	=>	'-ldap -gtk -xorg -pppd mysql imap ipv6 libwww maildir sasl ssl unicode xml apache2 -gpm ubac bcmath gd sockets truetype agent png -sqlite3 device-mapper dlz',
    features	=>	'buildpkg',
    mirrors	=>	'http://192.168.100.1:8080/gensetup/gentoo ${GENTOO_MIRRORS}',
    sync	=>	'',
    emerge_opts	=>	'-k',
  }

  portage::makeconf { 'SELinux policy types':
    ensure	=>	present,
    content	=>	'POLICY_TYPES="targeted strict mcs"',
  }

  portage::makeconf { 'Layman sourcing':
    ensure	=>	present,
    content	=>	'source /var/lib/layman/make.conf',
  }

  package_use { "app-admin/setools":
    use		=>	['python'],
    target	=>	"selinux",
  }

  package_use { "sys-libs/libselinux":
    use		=>	['static-libs', 'ruby'],
    target	=>	"selinux",
  }

  package_use { "dev-libs/libpcre":
    use		=>	['static-libs'],
    target	=>	"selinux",
  }

  package_use { "sys-apps/net-tools":
    use		=>	['old-output'],
    target	=>	"puppet",
  }

  package_use { "app-admin/puppet":
    use		=>	['augeas'],
    target	=>	"puppet",
  }

  # temporary fix for bug 439414
  #package_keywords { "=sys-fs/lvm2-2.02.93-r1":
  #  keywords	=>	['~amd64'],
  #  target	=>	"selinux",
  #}
}
