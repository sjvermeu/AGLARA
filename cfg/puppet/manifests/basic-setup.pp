# The 'basenode' node is a Puppet-default baseline node
node basenode {
  ######################################
  #
  # General variables
  #

  # Network config
  $puppet_server = "puppet.internal.genfic.com"
  $dns_servers = [ "192.168.1.1", "8.8.8.8" ]
  $domain = "internal.genfic.com"
}
