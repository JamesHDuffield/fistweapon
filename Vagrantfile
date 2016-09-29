# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
  config.vm.box = "ubuntu/trusty64"

  required_plugins = %w(vagrant-librarian-chef-nochef vagrant-vbguest)

  plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
  if not plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(' ')}"
    if system "vagrant plugin install #{plugins_to_install.join(' ')}"
      exec "vagrant #{ARGV.join(' ')}"
    else
      abort "Installation of one or more plugins has failed. Aborting."
    end
  end

  # Support filesystem notify event passthrough.
  config.vm.synced_folder ".", "/vagrant", fsnotify: true

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true
  config.vm.network :forwarded_port, guest: 5432, host: 5432, auto_correct: true

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.channel = "stable"
    chef.version = "12.10.24"
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe "vim"
    chef.add_recipe "postgresql::server"

    # Install Ruby 2.2, Bundler and Rails
    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.5"],
          global: "2.2.5",
          gems: {
            "2.2.5" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      postgresql: {
        config: {
          listen_addresses: "*",
          port:             "5432"
        },
        pg_hba: [
          {
            type:   "local",
            db:     "postgres",
            user:   "postgres",
            addr:   nil,
            method: "trust"
          },
          {
            type:   "host",
            db:     "all",
            user:   "all",
            addr:   "0.0.0.0/0",
            method: "md5"
          },
          {
            type:   "host",
            db:     "all",
            user:   "all",
            addr:   "::1/0",
            method: "md5"
          }
        ],
        password: {
          postgres: "password"
        }
      },
    }
  end
  #this should be cheffable, but it looks hard
  config.vm.provision :shell, inline: "createuser -U postgres -s vagrant || exit 0"
end