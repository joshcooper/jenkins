class jenkins::ssh {
#  include jenkins::ssh-pub-keys

  file { "${jenkins::home}/.ssh" :
    ensure => directory,
    require => User['jenkins'],
  }

  file { "${jenkins::home}/.ssh/id_rsa" :
    ensure => present,
    source => 'puppet:///modules/jenkins/id_rsa',
  }

  file { "${jenkins::home}/.ssh/id_rsa.pub" :
    ensure => present,
    source => 'puppet:///modules/jenkins/id_rsa.pub',
  }
}
