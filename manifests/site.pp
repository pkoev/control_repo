node default {
  file { '/root/README':
    ensure  => file,
    content => 'This is a readme',
    owner   => 'root'
    }
  file { '/root/README':
    owner   => 'root'
  }
}
node 'master.puppet.vm' {
  include role::master_server
}
node 'ghost.puppet.vm' {
  include role::app_server
}
node 'nemesis.puppet.vm' {
  include role::app_server
}
node 'warlord.puppet.vm' {
  include role::db_server
}
