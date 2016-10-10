class git {
    exec { 'install_git':
        provider => shell,
        command => 'sudo apt-get install -y git',
    }
}
