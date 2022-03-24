![M300-Banner](info.png)


# Inahltsverzeichnis
 1. [Einleitung](#Einleitung)
 
 1. [Umgebung](#Umgebung) 

 2. [Erklärung Code](#Erklärung)

 3. [Testen](#testen)

 4. [Quellenagabe](#quellenangabe)



<div id='Einleitung'/>

# Einleitung

<div id='Erklärung'/>

# Erklärung Code

```ruby
Vagrant.configure("2") do |config|

  # Fileserver
  config.vm.define "ubuntuserver" do |fileserver|
    fileserver.vm.hostname = "ubuntuserver"
    fileserver.vm.box = "ubuntu/xenial64"
    
    # Network Configs
    fileserver.vm.network "private_network", ip: "192.168.1.48"

    # VM Configs
    fileserver.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "Fileserver"

      # VM Specs
      vb.memory = "2048"
      vb.cpus = "2"
    end

    # Provision Script
    fileserver.vm.provision "shell", path: "provision/serverdeployment.sh"
  end
```
