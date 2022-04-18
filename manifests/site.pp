node default {
  file { '/root/README':
    ensure  => file,
    content => 'Thisi s a readme',
    owner   => 'root'
    }
}
