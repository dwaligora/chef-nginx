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

contrib_modules_path = "#{Chef::Config['file_cache_path']}/contrib_modules"

define :nginx_contrib_module_configure do
  # we want to pull out the subdir path from the tarball.  This is always the first entry in the
  # tar file.  We pull it off the top of the listing and chop off the trailing / and \n
  module_src_subdir = `tar tf #{params[:tarball_path]} 2>/dev/null | head -1`.chop.chomp('/')
  module_src_path = "#{contrib_modules_path}/#{module_src_subdir}"

  node.run_state['nginx_configure_flags'] << "--add-module=#{module_src_path}"
end

define :nginx_contrib_module, :packages => [], :checksum => '' do

  # install any packages required for this module
  params[:packages].each do |pkg|
    package pkg
  end

  # we are going to download the module tarball directly into our chef file cache
  tarball_path = "#{Chef::Config['file_cache_path']}/#{params[:name]}.tgz"

  # just for some better organization, we extract all of our module source code
  # into a common "contrib_modules" subdirectory in our file cache
  directory contrib_modules_path do
    recursive true
  end

  # pull down the tarball (if we don't already have the latest version by checksum)
  remote_file tarball_path do
    source params[:url]
    checksum params[:checksum] if params[:checksum]
  end

  # extract the source tarball
  bash "extract #{params[:name]} module" do
    code "tar xzf #{tarball_path} -C #{contrib_modules_path}"
  end

  # add our --add-module configuration to nginx source run_state
  nginx_contrib_module_configure do
    tarball_path tarball_path
  end
end
