Description of files in this repo:

- Vagrantfile: sets up the master VM and 3 agent VMs on a single machine.
- bootstrap_master.sh: does any relevant setup on the master VM
- bootstrap_agent.sh: does any relevant setup on any and all agent VMs
- response.varfile: required to set up Jira without user input
- shared: the shared folder that will be loaded onto the master VM
    - shared/modules: Puppet modules that will be copied into the master's Puppet directory

To automatically set up the virtual machines and install all modules, simply type "vagrant up" in the top-level directory of this repo.
Before doing this, however, please ensure the following:
- You have the Ubuntu disk image present in your computer's C:/Users/[user]/.vagrant.d/boxes directory

NOTE: Make sure the following files are located in the "shared" folder provided in the repository
- java: java.tar.gz
- jenkins: jenkins_2.1_all.deb
- jira: jira.bin and response.varfile
- maven.tar.gz
- mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar
- nexus-3.0.2-02-unix.tar.gz
- zabbix-3.2.1.tar.gz

Other things to note:
- The MySQL databases created do not have any root password set

When installation is complete, log into https://entmaster.qac.local on the master VM with user: admin, password: vagrantup. Go to the "Nodes" tab and press "Accept All" to connect the nodes to the master.
To access MCollective commands, run the command "sudo -i -u peadmin".
