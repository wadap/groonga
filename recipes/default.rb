#
# Cookbook Name:: groonga
# Recipe:: default
#
# Copyright 2013, nanapi.inc
#
# All rights reserved - Do Not Redistribute
#

%w[unzip].each do |v|
  package v do
    action :install
    not_if "which unzip"
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node.groonga.package}.zip" do
  source "http://packages.groonga.org/source/groonga/#{node.groonga.package}.zip"
  owner "root"
  group "root"
  mode  "0644"

  not_if do
    FileTest.file? "#{Chef::Config[:file_cache_path]}/#{node.groonga.package}.zip"
  end
end

script "install_groonga" do
  interpreter "bash"
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  unzip #{node.groonga.package}.zip && cd #{node.groonga.package}
  ./configure --prefix=#{node.groonga.root} --with-mecab-config=#{node.mecab.config}
  make
  #{node.paco.bin} -D make install
  EOH

  not_if do
    FileTest.directory? node.groonga.root
  end
end
