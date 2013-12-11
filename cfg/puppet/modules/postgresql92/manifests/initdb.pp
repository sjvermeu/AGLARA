# == Class: postgresql92::initdb
#
# This class calls the initdb tool to initiate the database files.
# See the main postgresql92 class for information about the parameters.
#

class postgresql92::initdb(
  $configdir	= params_lookup( 'configdir' ),
  $datadir	= params_lookup( 'datadir' ),
  $encoding	= params_lookup( 'encoding' ),
  $group	= params_lookup( 'group' ),
  $user		= params_lookup( 'user' ),
) inherits postgresql92::params {
  
  $initdb_command = "${initdb_path} -U ${user} -D \"${datadir}\" --encoding=\"${encoding}\""

  exec { 'postgresql92_initdb':
    command	=> $initdb_command,
    creates	=> "${datadir}/PG_VERSION",
    user	=> $user,
    group	=> $group,
    logoutput	=> on_failure,
  }

  Package['postgresql92'] -> Exec['postgresql92_initdb']
}
