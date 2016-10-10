# -*- mode: ruby -*-
# vi: set f=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "chad-thompson/ubuntu-trusty64-gui"
    config.vm.synced_folder "shared", "/tmp/shared"

    config.vm.provider :virtualbox do |vbox|
        vbox.gui = true
        vbox.memory = 4096
        vbox.cpus = 2
    end

    config.vm.define "master" do |master|
        master.vm.hostname = "vumaster.qac.local"
        master.vm.network :public_network, ip: "192.168.1.20"
        master.vm.provision :shell, path: "bootstrap_master.sh"

        master.vm.provider :virtualbox do |vbox|
            vbox.name = "VUMaster"
        end
    end

    config.vm.define "agent1" do |agent1|
        agent1.vm.hostname = "vuagent1.qac.local"
        agent1.vm.network :public_network, ip: "192.168.1.21"
        agent1.vm.provision :shell, path: "bootstrap_agent.sh"

        agent1.vm.provider :virtualbox do |vbox|
            vbox.name = "VUAgent 1"
        end
    end

    config.vm.define "agent2" do |agent2|
        agent2.vm.hostname = "vuagent2.qac.local"
        agent2.vm.network :public_network, ip: "192.168.1.22"
        agent2.vm.provision :shell, path: "bootstrap_agent.sh"

        agent2.vm.provider :virtualbox do |vbox|
            vbox.name = "VUAgent2"
        end
    end

    config.vm.define "agent3" do |agent3|
        agent3.vm.hostname = "vuagent3.qac.local"
        agent3.vm.network :public_network, ip: "192.168.1.23"
        agent3.vm.provision :shell, path: "bootstrap_agent.sh"

        agent3.vm.provider :virtualbox do |vbox|
            vbox.name = "VUAgent3"
        end
    end

end
