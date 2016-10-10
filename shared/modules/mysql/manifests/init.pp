class mysql {
    include mysql::install
}

class mysql::install {
    file { '/opt/mysql.tar':
        ensure => present,
        source => 'puppet:///modules/mysql/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar',
        owner => 'root',
        group => 'root',
        before => Exec['/opt/install_mysql.sh'],
    }

    file { '/opt/install_mysql.sh':
        ensure => present,
        source => 'puppet:///modules/mysql/install_mysql.sh',
        owner => 'root',
        group => 'root',
        before => Exec['/opt/install_mysql.sh'],
    }

    exec { 'sudo apt-get install -y libaio1':
        provider => shell,
        before => Exec['/opt/install_mysql.sh'],
    }

    exec { '/opt/install_mysql.sh':
        provider => shell,
        onlyif => '! mysql -V',
    }
}
