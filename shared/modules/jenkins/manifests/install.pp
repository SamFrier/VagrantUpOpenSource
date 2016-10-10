class jenkins::install {

file {'/opt/jenkins_2.1_all.deb':
ensure => present,
owner => 'root',
group => 'root',
source => 'puppet:///modules/jenkins/jenkins_2.1_all.deb',
before => Exec['installJenkins'],
}

file {'/opt/JenkinsInstall.sh':
ensure => present,
owner => 'root',
group => 'root',
source => 'puppet:///modules/jenkins/JenkinsInstall.sh',
before => Exec['installJenkins'],
}

exec {'installJenkins':
provider => shell,
command => '/opt/JenkinsInstall.sh',
onlyif => '! sudo service jenkins status',
}
}
