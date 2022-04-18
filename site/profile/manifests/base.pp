class profile::base {
  user {'admin':
    ensure => present,
  }
  host {'master.puppet.vm':
    ensure => present,
    ip => '192.168.56.101',
  }
  host {'ghost.puppet.vm':
    ensure => present,
    ip => '192.168.56.102',
  }
  host {'warlord.puppet.vm':
    ensure => present,
    ip => '192.168.56.104',
  }
  host {'nemesis.puppet.vm':
    ensure => present,
    ip => '192.168.56.103',
  }
  package {'vim':
    ensure => present,
  }
  package {'htop':
    ensure => present,
}
