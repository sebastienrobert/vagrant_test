Vagrant::Config.run do |config|
  config.vm.box = "lucid32"

  # The url from where the 'config.vm.box' box will be fetched if ...
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  # config.vm.boot_mode = :gui
  # config.vm.network "33.33.33.10"
  config.vm.forward_port "http", 80, 8080
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  config.vm.provision :puppet
end
