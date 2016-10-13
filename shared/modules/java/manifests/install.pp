class java::install {

file { '/opt/JavaInstall.sh':
ensure => present,
owner => 'root',
group => 'root',
source => 'puppet:///modules/java/JavaInstall.sh',
}

file { '/opt/java.tar.gz':
ensure => present,
owner => 'root',
group => 'root',
source => 'puppet:///modules/java/java.tar.gz',
}

exec { 'install_java':
provider => shell,
command => '/opt/JavaInstall.sh',
require => [File['/opt/JavaInstall.sh'], File['/opt/java.tar.gz']],
onlyif => '! java -version',
}
}
