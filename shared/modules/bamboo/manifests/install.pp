class bamboo::install {

    file { '/opt/BambooInstall.sh':
        ensure => present,
        owner => 'root',
        group => 'root',
        source => 'puppet:///modules/bamboo/BambooInstall.sh',
    }

    file { '/opt/atlassian-bamboo-5.13.2.tar.gz':
        ensure => present,
        owner => 'root',
        group => 'root',
        source => 'puppet:///modules/bamboo/atlassian-bamboo-5.13.2.tar.gz',
    }

    exec { 'install_bamboo':
        provider => shell,
        command => '/opt/BambooInstall.sh',
        require => [File['/opt/BambooInstall.sh'], File['/opt/atlassian-bamboo-5.13.2.tar.gz']],
        onlyif => '! -d /opt/atlassian-bamboo-5.13.2',
    }
}
