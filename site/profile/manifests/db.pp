class profile::db {
  $sst_user         = 'sstuser'
  $sst_password     = 'S3cr333t$'
  $backup_dir       = '/home/backup/mysql'
  $mysql_cluster_address = 'gcomm://192.168.56.102,192.168.56.103,192.168.56.104'

  # Galera configuration
  class {'mysql::server':
    package_name            => 'mariadb-server',
    root_password           => 'q1w2e3!@#',
    service_name            => 'mysql',
    create_root_my_cnf      => true,
    remove_default_accounts => true,
    manage_config_file      => true,
    override_options        => {
      'mysqld' => {
        'datadir'                 => '/var/lib/mysql',
        'bind_address'            => '0.0.0.0',
        'binlog-format'           => 'ROW',
        'default-storage-engine'  => 'InnoDB',
        'wsrep_provider'          => '/usr/lib/galera/libgalera_smm.so',
        'wsrep_provider_options'  => 'gcache.size=1G',
        'wsrep_cluster_name'      => 'galera_cluster',
        'wsrep_cluster_address'   => $mysql_cluster_address,
        'log-error'               => '/var/log/mysql/error.log',
        'wsrep_node_address'      => $facts['networking']['interfaces']['enp0s8']['ip'],
        'wsrep_node_name'         => $hostname,
        'innodb_buffer_pool_size' => '512M',
        'wsrep_sst_method'        => 'mariabackup',
        'wsrep_sst_auth'          => "${sst_user}:${sst_password}"
      },
      'mysqld_safe' => {
        'log-error'               => '/var/log/mysql/error.log'
      }
    }
  }

  # force creation of backup dir if not exist
  exec { "mkdir -p ${backup_dir}" :
    path   => ['/bin','/usr/bin'],
    unless => "test -d ${backup_dir}"
  }

  # create SST and backup user
  class { 'mysql::backup::xtrabackup' :
    xtrabackup_package_name => 'mariadb-backup',
    backupuser              => "${sst_user}",
    backuppassword          => "${sst_password}",
    backupmethod            => 'mariabackup',
    backupdir               => "${backup_dir}"
  }
}
