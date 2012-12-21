#########################
#
# Class myportage
#
# Manages portage settings for the AGLARA environment.
# The use of the portage module showed some deployment
# issues (like definitions that were not applied, and
# different behavior when ran through puppetd and through
# puppet).
#
class myportage {
  # Default portage settings
  file { "make.conf":
    ensure => present,
    path => "/etc/portage/make.conf",
    owner => "root",
    group => "root", 
    content => template("myportage/make.conf.erb"),
  }
  
  # Create package.use directory
  file { "/etc/portage/package.use":
    ensure => "directory",
    owner => "root",
    group => "root",
  }
  
  # Create package.accept_keywords directory
  file { "/etc/portage/package.accept_keywords":
    ensure => "directory",
    owner => "root",
    group => "root",
  }
  
  file { "package.use/selinux":
    ensure => present,
    owner => "root",
    group => "root",
    require => File['/etc/portage/package.use'],
    path => "/etc/portage/package.use/selinux",
    source => "puppet:///modules/myportage/package.use.selinux",
  }
  
  file { "package.use/puppet":
    ensure => present,
    owner => "root",
    group => "root",
    require => File['/etc/portage/package.use'],
    path => "/etc/portage/package.use/puppet",
    source => "puppet:///modules/myportage/package.use.puppet",
  }
  
  # Fix for 439414
  file { "package.accept_keywords/lvm":
    ensure => present,
    owner => "root",
    group => "root",
    require => File['/etc/portage/package.accept_keywords'],
    path => "/etc/portage/package.accept_keywords/lvm",
    source => "puppet:///modules/myportage/package.accept_keywords.lvm",
  }
}
