#
# Cookbook:: a2_on_bjc
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

## Obtain Chef Automate installation and admin tool
yum_package 'wget' 
yum_package 'unzip'

bash 'get_install_tools' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    wget https://s3-us-west-2.amazonaws.com/chef-automate-artifacts/current/latest/chef-automate-cli/chef-automate_linux_amd64.zip
    EOH
end

  bash 'get_install_tools' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    unzip chef-automate_linux_amd64.zip
    EOH
  end

execute 'chmod' do
    user 'root'
    cwd '/tmp'
  command 'chmod +x chef-automate'
  action :run
end

execute 'max_map_cnt' do
    user 'root'
    cwd '/tmp'
  command 'sysctl -w vm.max_map_count=262144'
  action :run
end

execute 'dirty_expire_centisecs' do
    user 'root'
    cwd '/tmp'
  command 'sysctl -w vm.dirty_expire_centisecs=20000'
  action :run
end

  bash 'create_default_config' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    ./chef-automate init-config
    EOH
  end

bash 'deploy_automate' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    ./chef-automate deploy config.toml
    EOH
end

bash 'get_install_tools' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    wget https://s3-us-west-2.amazonaws.com/anthonyrees/delivery.license
    EOH
end

bash 'install_license' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    ./chef-automate license apply delivery.license
    EOH
end

## Now navigate to https://automate-deployment.test
