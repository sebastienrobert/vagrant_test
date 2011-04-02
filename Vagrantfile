user = ENV['OPSCODE_USER'] || ENV['USER']
orgname = 'imetrical' || ENV['ORGNAME']
base_box = ENV['VAGRANT_BOX'] || 'lucid32'

Vagrant::Config.run do |config|
  config.vm.box = base_box

  # The url from where the 'config.vm.box' box will be fetched if ...
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  # config.vm.boot_mode = :gui
  # config.vm.network "33.33.33.10"
  config.vm.forward_port "http", 80, 8080
  config.vm.forward_port "httpdoc", 81, 8081
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  config.vm.share_folder("ekoform-dev", "/ekoform-dev", "/Users/daniel/Documents/NetBeansProjects/Ekoform")

  config.vm.provision :chef_server do |chef|
    # Set up some organization specific values based on environment variable above.
    chef.chef_server_url = "https://api.opscode.com/organizations/#{orgname}"
    chef.validation_key_path = "#{ENV['HOME']}/.chef/#{orgname}-validator.pem"
    chef.validation_client_name = "#{orgname}-validator"

    # Change the node/client name for the Chef Server
    chef.node_name = "#{user}-vagrant"

    # Put the client.rb in /etc/chef so chef-client can be run w/o specifying
    chef.provisioning_path = "/etc/chef"
    # logging
    chef.log_level = :info

    # adjust the run list to suit your testing needs
    chef.add_recipe("vagrant_main")
    #   chef.add_recipe "mysql"
    #   chef.add_role "web"
    #   # You may also specify custom JSON attributes:
    #   chef.json = { :mysql_password => "foo" }
    #chef.run_list = [
    #  "recipe[some_cookbook::some_recipe]"
    #  "role[some_role]"
    #]
  end
    
  # Enable and configure the chef solo provisioner
  config.vm.provision :chef_solo do |chef|
      # We're going to download our cookbooks from the web
      #chef.recipe_url = "http://files.vagrantup.com/getting_started/cookbooks.tar.gz"
      chef.cookbooks_path =  ["cookbooks", "opscodecookbooks"]

      # Tell chef what recipe to run. In this case, the `vagrant_main` recipe
      # does all the magic.
      chef.add_recipe("vagrant_main")
      #   chef.add_recipe "mysql"
      #   chef.add_role "web"
      #   # You may also specify custom JSON attributes:
      #   chef.json = { :mysql_password => "foo" }
    end

end
