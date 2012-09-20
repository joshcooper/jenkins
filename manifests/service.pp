class jenkins::service {
  file { 'c:\agent':
    ensure  => directory,
    require => Exec['java']
  }

  file { 'c:\agent\slave.jar':
    ensure => present,
    source => "puppet:///modules/jenkins/agent-${jenkins::version}/remoting.jar",
  }

  file { 'c:\agent\jenkins-slave.exe':
    ensure => present,
    mode   => 0770,
    source => "puppet:///modules/jenkins/agent-${jenkins::version}/jenkins-slave.exe",
  }

  file { 'c:\agent\jenkins-slave.xml':
    ensure  => present,
    content => template('jenkins/jenkins-slave.xml.erb'),
  }

  exec { 'install-service':
    command   => "sc.exe create ${jenkins::servicename} start= demand binpath= ${jenkins::serviceexe} displayname= ${jenkins::servicename}",
    path      => "${::path}",
    logoutput => true,
    unless    => "sc.exe query ${jenkins::servicename}",
    require   => File['c:\agent\slave.jar', 'c:\agent\jenkins-slave.exe', 'c:\agent\jenkins-slave.xml']
  }

  service { "${jenkins::servicename}":
    ensure    => running,
    enable    => true,
    require   => Exec['install-service'],
    subscribe => File['c:\agent\slave.jar', 'c:\agent\jenkins-slave.exe', 'c:\agent\jenkins-slave.xml']
  }
}
