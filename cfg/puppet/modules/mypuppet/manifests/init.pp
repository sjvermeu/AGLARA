#########################
#
# Class mypuppet
#
# Updates for Puppet
#
class mypuppet {
  # bashrc postinstall
  file { "puppet-postinstall":
    ensure => present,
    owner => "root",
    group => "root",
    mode => 755,
    require => File['/etc/portage/bashrc.d/app-admin'],
    path => "/etc/portage/bashrc.d/app-admin/puppet.postinst",
    source => "puppet:///modules/mypuppet/puppet.postinst",
  }

  # Create bashrc.d/app-admin directory
  file { "/etc/portage/bashrc.d/app-admin":
    ensure => "directory",
    owner => "root",
    group => "root",
  }

  # Create puppet subdir
  file { "/etc/portage/bashrc.d/app-admin/puppet":
    ensure => "directory",
    require => File['/etc/portage/bashrc.d/app-admin'],
    owner => "root",
    group => "root",
  }

  file { "puppet-openrcpatch":
    ensure => present,
    owner => "root",
    group => "root",
    require => File['/etc/portage/bashrc.d/app-admin/puppet'],
    path => "/etc/portage/bashrc.d/app-admin/puppet/openrc.patch",
    source => "puppet:///modules/mypuppet/openrc.patch",
  }

  file { "puppet.conf":
    ensure => present,
    owner => "root",
    group => "root",
    mode => 0644,
    path => "/etc/puppet/puppet.conf",
    source => "puppet:///modules/mypuppet/puppet.conf",
  }
}
