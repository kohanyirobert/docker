def shell_provision(vm, script_path)
  vm.provision(
    "shell",
    name: script_path,
    privileged: false,
    path: script_path,
  )
end

def smb_synced_folder(vm, host_path, guest_path)
  vm.synced_folder(
    host_path,
    guest_path,
    type: "smb",
    smb_username: ENV["SMB_USERNAME"],
    smb_password: ENV["SMB_PASSWORD"],
    mount_options: ["iocharset=utf8"],
  )
end

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2004"
  config.vm.box_version = "3.6.12"
  config.vm.hostname = "docker"
  config.vm.network "private_network", ip: "10.0.100.100", netmask: "255.255.255.0"
  smb_synced_folder config.vm, ".", "/vagrant"
  smb_synced_folder config.vm, "C:/Users", "/c/Users"
  shell_provision config.vm, "docker.sh"
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 4096
    vb.linked_clone = true
  end 
end
  