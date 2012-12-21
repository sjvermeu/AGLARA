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
    command => "eix-update",
    creates => "/var/cache/eix/portage.eix",
  }
  
  # Make sure SSH is up and running
  package { ssh:
    ensure => installed,
    require => exec['create_eix_cache'],
  }
  service { sshd:
    ensure => running,
    require => [
      File['/etc/ssh/sshd_config'],
      Package[ssh]
    ],
  }
}
