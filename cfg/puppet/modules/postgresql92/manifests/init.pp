# == Class: postgresql92
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module.
#   Can also be defined as the (top scope) variable $postgresql92_absent.
#
# [*configdir*]
#   Directory containing the PostgreSQL configuration files.
#
# [*datadir*]
#   Directory containing the PostgreSQL data files.
#
# [*disable*]
#   Set to 'true' to disable init service(s) managed by module
#   (so the service is ensured to not be running).
#
# [*disable_boot*]
#   Set to 'true' to remove the init service(s) from the 
#   runlevels, without checking if it is running. 
#
# [*disable_initdb*]
#   Set to 'true' to disable running initdb when no database
#   files are present yet.
#
# [*encoding*]
#   Encoding of the database instance
#
# [*group*]
#   Runtime group of the PostgreSQL service. Defaults to 'postgres'.
#
# [*initdb_path*]
#   Path towards the initdb binary.
#
# [*package*]
#   Name of the postgresql installation package.
#
# [*port*]
#   The port on which the postgresql instance listens on.
#
# [*process*]
#   The name of the postgresql process
#
# [*service*]
#   Name of the postgresql service
#
# [*service_status*]
#   If the postgresql service init script supports status argument
#
# [*service_autorestart*]
#   Automatically restarts the postgresql service when there is a change in
#   configuration files. Default is false.
#
# [*user*]
#   Runtime user of the PostgreSQL service. Defaults to 'postgres'.
#
# [*version*]
#   The postgresql version to install. If not specified, the module will use
#   whatever version is the default for your OS distro.

#
# == Examples:
#
#   class { 'postgresql02':
#     package => 'postgresql-server',
#     version => '9.2.4',
#   }

class postgresql92 (
  $absent		= params_lookup( 'absent' ),
  $configdir		= params_lookup( 'configdir' ),
  $datadir		= params_lookup( 'datadir' ),
  $disable		= params_lookup( 'disable' ),
  $disableboot		= params_lookup( 'disableboot' ),
  $disableinitdb	= params_lookup(' disableinitdb' ),
  $encoding		= params_lookup( 'encoding' ),
  $group		= params_lookup( 'group' ),
  $initdb_path		= params_lookup( 'initdb_path'),
  $package		= params_lookup( 'package' ),
  $port			= params_lookup( 'port' ),
  $process		= params_lookup( 'process' ),
  $service		= params_lookup( 'service' ),
  $service_autorestart	= params_lookup( 'service_autorestart' , 'global' ),
  $service_status	= params_lookup( 'service_status' ),
  $user			= params_lookup( 'user' ),
  $version		= params_lookup( 'version' ),
) inherits postgresql92::params {

  $bool_absent			= any2bool( $absent )
  $bool_disable			= any2bool( $disable )
  $bool_disableboot		= any2bool( $disableboot )
  $bool_disableinitdb		= any2bool( $disableinitdb )
  $bool_service_autorestart	= any2bool( $service_autorestart )

  ##
  ## Definition of logic variables 
  ##

  # Does this module need to manage the resource, or is it explicitly
  # asked to uninstall?
  $manage_package = $postgresql92::bool_absent ? {
    true	=> 'absent',
    false	=> $postgresql92::version,
  }

  $manage_service_autorestart = $postgresql92::bool_service_autorestart ? {
    true	=> Service[postgresql92],
    false	=> undef,
  }

  # Does the service need to be enabled (added to the default runlevel)
  # We first check if disableboot is set. 
  # If not, check if the service needs to be disabled (in which case it
  # shouldn't be in the runlevel). And if that isn't set, we check if the
  # product had to be uninstalled.
  $manage_service_enable = $postgresql92::bool_disableboot ? {
    true	=> false,
    default	=> $postgresql92::bool_disable ? {
        true	=> false,
        default	=> $postgresql92::bool_absent ? {
          true	=> false,
          false	=> true,
      },
    },
  }

  # Does the service need to be running (ensure)
  $manage_service_ensure = $postgresql92::bool_disable ? {
    true	=> 'stopped',
    default	=> $postgresql92::bool_absent ? {
      true	=> 'stopped',
      default	=> 'running',
    },
  }

  ## Resources

  package { 'postgresql92':
    ensure 	=> $postgresql92::manage_package,
    name	=> $postgresql92::package,
  }

  service { 'postgresql92':
    ensure	=> $postgresql92::manage_service_ensure,
    name	=> $postgresql92::service,
    enable	=> $postgresql92::manage_service_enable,
    hasstatus	=> $postgresql92::service_status,
    pattern	=> $postgresql92::process,
    require	=> [ Package['postgresql92'] , File['/etc/conf.d/postgresql-9.2'] ],
  }

  file { '/etc/conf.d/postgresql-9.2':
    ensure => present,
    path => '/etc/conf.d/postgresql-9.2',
    owner => "root",
    group => "root",
    content => template("postgresql92/conf.d.postgresql-9.2.erb"),
  }

  if (! $postgresql92::bool_disableinitdb) {
    include postgresql92::initdb

    Package['postgresql92'] -> Class['postgresql92::initdb'] -> Service['postgresql92']
  } 
}

