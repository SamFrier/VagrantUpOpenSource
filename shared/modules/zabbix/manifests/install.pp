class zabbix::install{

file {'/opt/zabbixAgentInstall2.sh':
ensure => present,
owner => 'root',
group => 'root',
source => 'puppet:///modules/zabbix/zabbixAgentInstall2.sh',
}

file { '/opt/zabbix-3.2.1.tar.gz':
ensure => present,
owner => 'root',
group => 'root',
source => 'puppet:///modules/zabbix/zabbix-3.2.1.tar.gz',
}

exec { 'install_zabbix':
provider => shell,
command => '/opt/zabbixAgentInstall2.sh',
require => [File['/opt/zabbixAgentInstall2.sh'], File['/opt/zabbix-3.2.1.tar.gz']],
onlyif => '! zabbix_agentd -V',
}
}

