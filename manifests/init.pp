class usermanagement {
  file { '/usr/local/bin/yaml2json':
    ensure => file,
    source => 'puppet:///modules/usermanagement/yaml2json',
  }
}
