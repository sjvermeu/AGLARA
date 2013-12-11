##
## test.internal.genfic.com
##
node 'test.internal.genfic.com' inherits basenode {
  $my_ip4address = "192.168.100.152"
  $my_ip6address = "2001:db8:81:e2::d8:e8fc:a2dc"

  class {"general": }
  class {"myportage":
    stable => false
  }
}
