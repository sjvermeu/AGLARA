# Class: postgresql92::params
#
# This class defines the default parameters used by the main module class
# postgresql92. Operating system differences in names and paths are addressed
# here.
#
# == Variables
#
# Refer to postgresql92 class for the variables defined here
# 
# == Usage
#
# This class is not intended to be used directly.

class postgresql92::params {
  
  ## Related parameters

  $absent  = false

  $configdir = $::operatingsystem ? {
    Gentoo	=> '/etc/postgresql-9.2',
    default	=> '/var/lib/postgresql/9.2/data',
  }

  $datadir = $::operatingsystem ? {
    Gentoo	=> '/var/lib/postgresql/9.2/data',
    default	=> '/var/lib/postgresql92/data',
  }

  $disable = false

  $disableboot = false

  $disableinitdb = false

  $encoding = 'UTF8'

  $group = $::operatingsystem ? {
    Gentoo	=> 'postgres',
    default	=> 'postgres',
  }

  $initdb_path = $::operatingsystem ? {
    default	=> '/usr/bin/initdb',
  }

  $package = $::operatingsystem ? {
    Gentoo	=> 'postgresql-server',
    default	=> 'postgresql',
  }

  $port = 5432

  $process = $::operatingsystem ? {
    Gentoo	=> 'postgres',
    default	=> 'postmaster',
  }

  $service = $::operatingsystem ? {
    Gentoo	=> 'postgresql-9.2',
    default	=> 'postgresql',
  }

  $service_autorestart = false

  $service_status = $::operatingsystem ? {
    Gentoo	=> false,
    default	=> true,
  }

  $user = $::operatingsystem ? {
    Gentoo	=> 'postgres',
    default	=> 'postgres',
  }

  $version = 'present'
}
