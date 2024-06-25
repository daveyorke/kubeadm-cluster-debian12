# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.


# Number of Worker Nodes
WORKER_COUNT        = 4

# CPU and MEMORY 
CPUS_MASTER_NODE    = 4
MEMORY_MASTER_NODE  = 4096

CPUS_WORKER_NODE    = 2
MEMORY_WORKER_NODE  = 2048


Vagrant.configure("2") do |config|

#   config.trigger.after :up do |trigger|
#     trigger.name = "Join workers after vagrant up"
#     trigger.info = "Join workers after vagrant up"
#     trigger.run = {path: "./join-workers.sh"}
#   end
  
  # All VMs get this basic configuration

  # Add entries for master and all workers in /etc/hosts
   config.vm.provision "shell", inline: "echo '192.168.25.10 master' | sudo tee -a /etc/hosts"
   (1..WORKER_COUNT).each do |i|
     config.vm.provision "shell", inline: "echo '192.168.25.#{i+10} worker#{i}' | sudo tee -a /etc/hosts"
   end

  config.vm.provision "shell", path: "install-common.sh"




  #############################
  # MASTER NODE Configuration #
  #############################

  config.vm.define "master" do |master|

    master.vm.box = "generic/debian12"

    master.vm.provider :libvirt do |domain|
      domain.memory = MEMORY_MASTER_NODE    
      domain.cpus = CPUS_MASTER_NODE    
    end
    
    # Set Private IP
    master.vm.network :private_network, :ip => "192.168.25.10"
    
    # Set hostname 
    master.vm.provision "shell", inline: "sudo hostnamectl hostname master"


    # Install and configure kubernetes to control plane
    # master.vm.provision "shell", path: "install-common.sh"
    master.vm.provision "shell", path: "install-master.sh"
  end

  ################################
  # WORKER NODE(S) Configuration #
  ################################

  (1..WORKER_COUNT).each do |i|

    config.vm.define "worker#{i}" do |worker|

      worker.vm.box = "generic/debian12"

      worker.vm.provider :libvirt do |domain|
        domain.memory = MEMORY_WORKER_NODE
        domain.cpus   = CPUS_WORKER_NODE
      end

      # Set Private IP
      worker.vm.network :private_network, :ip => "192.168.25.#{i+10}"

      # Set hostname
      worker.vm.provision "shell", inline: "sudo hostnamectl hostname worker#{i}"

      # Add entries for master and all workers in /etc/hosts
      # worker.vm.provision "shell", inline: "echo '192.168.25.10 master' | sudo tee -a /etc/hosts"
      # worker.vm.provision "shell", inline: "echo '192.168.25.#{i+10} worker#{i}' | sudo tee -a /etc/hosts"

      # Install and configure kubernetes to worker nodes
      # worker.vm.provision "shell", path: "install-common.sh"
      worker.vm.provision "shell", path: "install-worker.sh"
    end

  end

end
