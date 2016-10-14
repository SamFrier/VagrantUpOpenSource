Description of files in this repo:

- Vagrantfile: sets up the master VM and a number of agent VMs on a single machine.
    - You can set the number of agents using the AGENTS variable
- bootstrap_master.sh: does any relevant setup on the master VM
- bootstrap_agent.sh: does any relevant setup on any and all agent VMs
- shared: the shared folder that will be loaded onto the master VM
    - shared/modules: Puppet modules that will be copied into the master's Puppet directory
    - shared/installZabbixServer.sh: sets up the Zabbix server on the master VM
    - shared/setupDatabase.sql: sets up the database for the Zabbix server

To automatically set up the virtual machines and install all modules, simply double click the startup.sh file.
Before doing this, however, please ensure the following:
- You have the Ubuntu disk image present in your computer's C:/Users/[user]/.vagrant.d/boxes directory
- Make sure the following files are located in the "shared" folder provided in the repository
    - java: java.tar.gz
    - jenkins: jenkins_2.1_all.deb
    - jira: jira.bin and response.varfile
    - maven.tar.gz
    - atlassian-bamboo-5.13.2.tar.gz
    - mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar
    - nexus-3.0.2-02-unix.tar.gz
    - zabbix-3.2.1.tar.gz

Other things to note:

- The MySQL databases created do not have any root password set
- The MySQL databases created on the agents do not have any root password set
- The Zabbix database on the master has user 'zabbix' with password 'vagrantup'

Ports available on 'fqdn:port': (fqdn is either 'vumaster.qac.local' or 'vuagent#.qac.local' where # is agent number)
- Jira = 8082
- Jenkins = 8080
- Nexus = 8081
- Bamboo = 8085

Zabbix server
Zabbix site = http://fqdn/zabbix, user: Admin, password: zabbix
