class general {
  ###############################
  #
  # General setup
  #

  # Manage /etc/hosts
  include hosts

  # Setup portage settings
  include myportage
	
  # Setup host configuration
  include mysysconf
	
  # Run eix-update if no cache exists
  exec { "create_eix_cache":
    command => "/usr/bin/eix-update",
    creates => "/var/cache/eix/portage.eix",
  }
  
  # Make sure SSH is up and running
  package { ssh:
    ensure => installed,
    require => Exec['create_eix_cache'],
  }
  service { sshd:
    ensure => running,
    require => [
      File['/etc/ssh/sshd_config'],
      Package[ssh]
    ],
  }

  # Dependency for net info
  service { "net.eth0":
    ensure => running,
  }
 
  # Have packages folder mounted
  mount { "/usr/portage/packages":
    ensure => mounted,
    device => "gateway:gentoo/packages",
    atboot => true,
    fstype => "nfs4",
    options => "soft,timeo=30",
  }

  # SELinux portage_use_nfs should be on
  selboolean { "portage_use_nfs":
    name => "portage_use_nfs",
    persistent => true,
    value => on,
  }
}
