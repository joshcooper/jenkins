class jenkins::registry {
  include registry

  # enable rdp
  registry_value { 'hklm\SYSTEM\CurrentControlSet\Control\Terminal Server\fDenyTSConnections':
    ensure => present,
    type   => dword,
    data   => 0,
  }
}
