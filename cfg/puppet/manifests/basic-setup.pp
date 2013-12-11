# The 'basenode' node is a Puppet-default baseline node
node "basenode" {
  ######################################
  #
  # General variables
  #

  # Network config
  $dns_servers = [ "192.168.1.1", "8.8.8.8" ]
  $domain = "internal.genfic.com"
  $defaultgw = "192.168.100.1"

  Service {
    provider => openrc_hardened,
    hasstatus => false,
  }
}
