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

  bash 'create_default_config' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    ./chef-automate init-config
    EOH
  end

#   bash 'deploy_automate' do
#     user 'root'
#     cwd '/tmp'
#     code <<-EOH
#     sudo ./chef-automate deploy config.toml --skip-preflight
#     EOH
#   end