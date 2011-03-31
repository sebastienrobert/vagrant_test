require_recipe "apt"
require_recipe "apache2"
require_recipe "php"

# mongo
execute "mongo-10gen-key" do
  command "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
  action :run                                                                                                                                                
end

# deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen
apt_repository "mongo10gen" do
  uri "http://downloads-distro.mongodb.org/repo/ubuntu-upstart"
  distribution "dist"
  components ["10gen"]
  action :add
end

# Some neat package (subversion is needed for "subversion" chef ressource)
%w{ iftop htop curl mongodb-10gen }.each do |a_package|
  package a_package
end

execute "mongo-copy-forms-ci" do
  command %q(mongo --eval 'db.copyDatabase("forms_ci", "forms_ci", "ci.axialdev.net");')
  action :run                                                                                                                                                
end

execute "mongo-count-quests" do
  command %q(mongo --eval 'db.quests.count()' forms_ci)
  action :run                                                                                                                                                
end


execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "ekoform-dev" do
  template "ekoform-dev.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end

