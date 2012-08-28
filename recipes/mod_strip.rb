#
# Cookbook Name:: nginx
# Recipe:: mod_strip
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012, Riot Games
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

mstr_src_filename = ::File.basename(node['nginx']['mod_strip']['url'])
mstr_src_filepath = "#{Chef::Config['file_cache_path']}/#{mstr_src_filename}"
mstr_extract_path = "#{Chef::Config['file_cache_path']}/nginx_mod_strip_module/#{node['nginx']['mod_strip']['checksum']}"

remote_file mstr_src_filepath do
  source node['nginx']['mod_strip']['url']
  checksum node['nginx']['mod_strip']['checksum']
  owner "root"
  group "root"
  mode 0644
end

bash "extract_mod_strip_module" do
  cwd ::File.dirname(mstr_src_filepath)
  code <<-EOH
    mkdir -p #{mstr_extract_path}
    tar xzf #{mstr_src_filename} -C #{mstr_extract_path}
    mv #{mstr_extract_path}/*/* #{mstr_extract_path}/
  EOH

  not_if { ::File.exists?(mstr_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{mstr_extract_path}"]
  
