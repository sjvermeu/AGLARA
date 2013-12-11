#########################
#
# Class mypuppet
#
# Updates for Puppet
#
class mypuppet {
  # bashrc postinstall
  file { "puppet-postinstall":
    ensure => absent,
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

  file { "puppet-openrc_hardened":
    ensure => absent,
    owner => "root",
    group => "root",
    require => File['/etc/portage/bashrc.d/app-admin/puppet'],
    path => "/etc/portage/bashrc.d/app-admin/puppet/openrc_hardened.rb",
    source => "puppet:///modules/mypuppet/openrc_hardened.rb",
  }

  file { "/etc/portage/package.accept_keywords/puppet":
    ensure => present,
    owner => "root",
    group => "root",
    mode => 0644,
    require => File['/etc/portage/package.accept_keywords'],
    path => "/etc/portage/package.accept_keywords/puppet",
    source => "puppet:///modules/mypuppet/package.accept_keywords.puppet",
  }

  file { "/etc/portage/package.use/puppet":
    ensure => present,
    owner => "root",
    group => "root",
    require => File['/etc/portage/package.use'],
    path => "/etc/portage/package.use/puppet",
    source => "puppet:///modules/mypuppet/package.use.puppet",
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
