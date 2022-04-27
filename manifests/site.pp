node default {
  file { '/root/README':
    ensure  => file,
    content => 'This is a readme',
    owner   => 'root'
    }
}
node 'master.puppet.vm' {
  include role::master_server
  file { '/root/README':
    ensure  => file,
    content =>  "Welcome to ${fqdn}\n",
    owner   => 'root'
  }
}
node 'ghost.puppet.vm' {
  include role::app_server
  include role::db_server
  file { '/root/README':
    ensure  => file,
    content => $fqdn,
    owner   => 'root'
  }
}
node 'nemesis.puppet.vm' {
  include role::app_server
  include role::db_server
  file { '/root/README':
    ensure  => file,
    content => $fqdn,
    owner   => 'root'
  }
}
node 'warlord.puppet.vm' {
  include role::db_server
  file { '/root/README':
    ensure  => file,
    content => $fqdn,
    owner   => 'root'
  }
}
