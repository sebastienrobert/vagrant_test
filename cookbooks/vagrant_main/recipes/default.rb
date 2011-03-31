require_recipe "apt"
require_recipe "apache2"
require_recipe "php"

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "ekoform-dev" do
  template "ekoform-dev.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end
