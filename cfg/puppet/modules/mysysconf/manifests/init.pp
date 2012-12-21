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
    content => template("mysysconf/net.erb"),
  }
  
  # Keep hostname fixed (should already be ok)
  file { "/etc/conf.d/hostname":
    ensure => present,
    content => "hostname=\"${hostname}\"",
  }
  
  # Ensure proper SSHd configuration
  file { "/etc/ssh/sshd_config":
    ensure => present,
    source => "puppet:///modules/mysysconf/sshd_config",
  }
}
