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
}
