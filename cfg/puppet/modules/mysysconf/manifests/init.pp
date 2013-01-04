#########################
#
# Class mysysconf
#
# Manages basic system settings for an image.
#
class mysysconf {
  
  # Network settings
  file { "/etc/conf.d/net":
    ensure => present,
    owner => "root",
    group => "root",
    content => template("mysysconf/net.erb"),
    notify => Service["net.eth0"],
  }
  
  # Keep hostname fixed (should already be ok)
  file { "/etc/conf.d/hostname":
    ensure => present,
    owner => "root",
    group => "root",
    content => "hostname=\"${hostname}\"",
  }
  
  # Ensure proper SSHd configuration
  file { "/etc/ssh/sshd_config":
    ensure => present,
    notify => Service["sshd"],
    mode => 0600,
    owner => "root",
    group => "root",
    source => "puppet:///modules/mysysconf/sshd_config",
  }
 
  # Set ima policy init script
  file { "/etc/init.d/ima_policy":
    ensure => present,
    mode => 0640,
    owner => "root",
    group => "root",
    source => "puppet:///modules/mysysconf/ima_policy",
  }

  # Set evm and security keys script
  file { "/etc/init.d/security_keys":
    ensure => present,
    mode => 0640,
    owner => "root",
    group => "root",
    source => "puppet:///modules/mysysconf/security_keys",
  }

  # SELinux setenforce init script
  file { "/etc/init.d/selinux_enforce":
    ensure => present,
    mode => 0640,
    owner => "root",
    group => "root",
    source => "puppet:///modules/mysysconf/selinux_enforce",
  }
}
