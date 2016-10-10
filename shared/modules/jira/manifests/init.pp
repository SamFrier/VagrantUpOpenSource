class jira {

        $FILE="puppet:///modules/jira"
        Exec {
                path => ['/usr/bin', '/bin'],
        }
        file { "/opt/jira.bin":
                ensure => "present",
                source => "${FILE}/jira.bin",
                owner => vagrant,
                mode => 755,
                before => Exec['allow jira'],
        }
        file { "/opt/response.varfile":
                ensure => "present",
                source => "${FILE}/response.varfile",
                owner => vagrant,
                before => Exec['allow jira'],
        }
        exec { 'allow jira':
                cwd => "/opt",
                command => 'chmod a+x jira.bin',
                before => Exec['extract jira'],
        }
        exec { 'extract jira':
                cwd => "/opt",
		provider => shell,
                command => './jira.bin -q -varfile response.varfile',
                onlyif => '! sudo service jira status',
        }
}


