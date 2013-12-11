##
## pg1.internal.genfic.com
##
node 'pg1.internal.genfic.com' inherits basenode {
  $my_ip4address = "192.168.100.153"
  $my_ip6address = "2001:db8:81:e2::62fe:c886:d574"

  class {"general": }
  class {"myportage":
    stable => true
  }

  class {"postgresql92": }
}
