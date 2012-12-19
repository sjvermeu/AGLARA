#########################
#
# Class hosts
#
# Manages /etc/hosts
#
class hosts {
  file { "hosts":
    ensure => present,
    path => "/etc/hosts",
    content => template("hosts/hosts.erb"),
  }
}
