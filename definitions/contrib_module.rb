#
# Cookbook Name:: nginx
# Definition:: contrib_module.rb
# Author:: AJ Christensen <aj@junglist.gen.nz>
# Author:: Matt Wormley <matt@wormley.net>
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

define :nginx_contrib_module, :url => '', :packages => [], :checksum => nil do

  # install any packages required for this module
  params[:packages].each do |pkg|
    package pkg
  end

  # we are going to download the module tarball directly into our chef file cache
  tarball_path = "#{Chef::Config['file_cache_path']}/#{params[:name]}.tgz"
  src_parent = "#{Chef::Config['file_cache_path']}/#{params[:name]}_src"

  directory src_parent do
    recursive true
  end

  # pull down the tarball (if we don't already have the latest version by checksum)
  remote_file tarball_path do
    source params[:url]
    checksum params[:checksum] if params[:checksum]
  end

  # extract the source tarball
  bash "extract #{params[:name]} module" do
    code "tar xzf #{tarball_path} -C #{src_parent}"
  end

  node.run_state['nginx_configure_flags'] << "--add-module=#{src_parent}/*"
end
