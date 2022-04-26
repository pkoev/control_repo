class profile::db {
  class mongodb::mongos {
    port    => 27018,
    verbose => true, 
    configdb => ['configsvr1.example.com:27018'],
    create_admin => true,
    admin_username => 'tadmin',
    admin_password => 'tpass',
    ensure => present,
  } 
}
