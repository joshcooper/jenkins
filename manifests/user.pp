class jenkins::user {
  user { 'jenkins':
    ensure   => present,
    managehome => true,
    home     => "${jenkins::home}",
    password => 'some password',
    groups   => ['Administrators', 'Users'],
  }
}
