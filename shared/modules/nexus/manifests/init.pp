class nexus {
	
	file { "/opt/nexus-3.0.2-02-unix.tar.gz":
                ensure => 'present',
		source => "puppet:///modules/nexus/nexus-3.0.2-02-unix.tar.gz",
                before => Exec['installN'],
        }

	file { "/opt/installNexus.sh":
		ensure => 'present',
		source => "puppet:///modules/nexus/installNexus.sh",
		owner => 'root',
		group => 'root',
		mode => '0777',
		before => Exec['installN'],
		notify => Exec['installN'],
	}

	exec { 'installN':
		cwd => '/opt',
		path => '/usr/bin',
		provider => shell,
		command => './installNexus.sh',
                onlyif => '! -d /opt/nexus-3.0.2-02',
	}
}
