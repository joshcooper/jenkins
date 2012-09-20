class jenkins::git {
  file { "${jenkins::home}/.gitconfig" :
    ensure   => present,
    source   => 'puppet:///modules/jenkins/gitconfig',
    require  => User['jenkins'],
  }

  file { 'git-installer':
    path   => "${jenkins::packages}\\Git-1.7.11-preview20120710.exe",
    ensure => present,
    mode   => 0750,
    source => 'puppet:///modules/jenkins/Git-1.7.11-preview20120710.exe',
  }

  # See http://unattended.sourceforge.net/InnoSetup_Switches_ExitCodes.html
  exec { 'git':
    command => 'cmd.exe /c start /w c:\packages\Git-1.7.11-preview20120710.exe /SP- /VERYSILENT /SUPPRESSMSGBOXES',
    logoutput => true,
    path      => "${::path}",
    creates   => $architecture ? {
      x64     => 'c:\Program Files (x86)\Git\bin\git.exe',
      default => 'c:\Program Files\Git\bin\git.exe',
    },
    require   => File['git-installer'],
  }
}
