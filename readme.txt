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
- All of the installers are copied into their respective folders (see below).

NOTE: the "files" directories for each module don't currently contain the required installers due to GitHub's file size limitations. Before running "vagrant up", please copy the following files into each module's "files" directory:
- bamboo: atlassian-bamboo-5.13.2.tar.gz
- java: java.tar.gz
- jenkins: jenkins_2.1_all.deb
- jira: jira.bin and response.varfile
- maven: maven.tar.gz
- mysql: mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar
- nexus: nexus-3.0.2-02-unix.tar.gz

Other things to note:
- The MySQL databases created do not have any root password set
