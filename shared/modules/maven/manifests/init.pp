class maven {

        require java
	
	file { "/opt/maven.tar.gz":
                ensure => 'present',
		source => 'puppet:///modules/maven/maven.tar.gz',
                before => Exec['installM'],
        }

	file { "/opt/installMaven.sh":
		ensure => 'present',
		source => 'puppet:///modules/maven/installMaven.sh',
		owner => 'root',
		group => 'root',
		mode => '0777',
		before => Exec['installM'],
		notify => Exec['installM'],
	}

	exec { 'installM':
		cwd => '/opt',
		path => '/usr/bin',
		provider => shell,
		command => './installMaven.sh',
		onlyif => '! mvn -version',
	}
}
