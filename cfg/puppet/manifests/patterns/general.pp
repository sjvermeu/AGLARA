class general {
  ###############################
  #
  # General setup
  #

  # Manage /etc/hosts
  include hosts

  # Setup host configuration
  include mysysconf

  # Setup puppet configuration
  include mypuppet
	
  # Run eix-update if no cache exists
  exec { "create_eix_cache":
    command => "/usr/bin/eix-update",
    creates => "/var/cache/eix/portage.eix",
  }
  
  # Make sure SSH is up and running
  package { openssh:
    ensure => installed,
    require => Exec['create_eix_cache'],
  }
  service { sshd:
    ensure => running,
    require => [
      File['/etc/ssh/sshd_config'],
      Package[openssh]
    ],
  }

  # Dependency for net info
  service { "net.eth0":
    ensure => running,
  }
 
  # Have packages folder mounted
  mount { "/usr/portage/packages":
    ensure => present,
    device => "gateway:gentoo/packages",
    atboot => true,
    fstype => "nfs4",
    options => "soft,timeo=30",
  }

  # puppet folder
  file { "/mnt/puppet":
    ensure => "directory",
  }

  # Have puppet folder mounted
  mount { "/mnt/puppet":
    ensure => present,
    require => File['/mnt/puppet'],
    device => "gateway:puppet",
    atboot => true,
    fstype => "nfs4",
    options => "soft,timeo=30,ro",
  }

  # SELinux portage_use_nfs should be on
  selboolean { "portage_use_nfs":
    name => "portage_use_nfs",
    persistent => true,
    value => on,
  }
}
