class profile::db {
  class mongodb::mongos {
    port    => 27018,
    verbose => true, 
    configdb => ['ghost.puppet.vm:27018'],
    create_admin => true,
    admin_username => 'tadmin',
    admin_password => 'tpass',
    ensure => present,
  } 
}
