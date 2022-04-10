Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = "20220315.0.0"
  config.vm.hostname = "docker"
  config.vm.network "private_network", ip: "10.0.100.100", netmask: "255.255.255.0"
  config.vm.synced_folder ".", "/vagrant", type: "smb"
  config.vm.synced_folder "C:/Users", "/c/Users",  type: "smb"
  config.vm.provision "shell", name: "docker.sh", privileged: false, path: "docker.sh"
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 4096
    vb.linked_clone = true
  end 
  config.vbguest.no_install = true
end
  