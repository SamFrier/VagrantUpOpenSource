# -*- mode: ruby -*-
# vi: set f=ruby :

AGENTS=3

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

    AGENTS.times do |i|
        config.vm.define "agent#{i+1}" do |agent|
            agent.vm.hostname = "vuagent#{i+1}.qac.local"
            agent.vm.network :public_network, ip: "192.168.1.2#{i+1}"
            agent.vm.provision :shell, path: "bootstrap_agent.sh"

            agent.vm.provider :virtualbox do |vbox|
                vbox.name = "VUAgent #{i+1}"
            end
        end
    end

end
