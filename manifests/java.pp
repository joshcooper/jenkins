class jenkins::java {
  file { 'jre-installer':
    path   => "${jenkins::packages}\\jre-7u5-windows-i586.exe",
    ensure => present,
    mode   => 0750,
    source => 'puppet:///modules/jenkins/jre-7u5-windows-i586.exe',
  }
      
  exec { 'java':
    command   => 'cmd.exe /c start /w c:\packages\jre-7u5-windows-i586.exe /s REBOOT=Suppress INSTALLDIR=c:\java JAVAUPDATE=0',
    logoutput => true,
    path      => "${::path}",
    creates   => "${jenkins::javaexe}",
    require   => File['jre-installer'],
  }
}
