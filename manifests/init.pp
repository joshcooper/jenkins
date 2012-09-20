class jenkins {
  $home = 'C:/Users/jenkins'
  $version = '1.465'
  $servicename = 'jenkins-agent'
  $serviceexe  = 'c:\\agent\\jenkins-slave.exe'
  $agentname = 'agent'
  $jenkinsurl = 'http://ec2-107-20-47-55.compute-1.amazonaws.com:8080'
  $jnlp  = "${jenkinsurl}/computer/${agentname}/slave-agent.jnlp"
  $javaargs = "-Xrs -jar c:\\agent\\slave.jar -jnlpUrl ${jnlp}"
  $javaexe  = 'c:\java\bin\java.exe'
  $packages = 'c:\packages'
  
  file { $packages:
    ensure => directory,
  }

  include jenkins::user
  include jenkins::git
  include jenkins::ssh
  include jenkins::java
  include jenkins::service
  include jenkins::registry
}
