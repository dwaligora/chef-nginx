#
# Cookbook Name:: nginx
# Recipe:: upstream_fair
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

upsf_src_filename = ::File.basename(node['nginx']['upstream_fair']['url'])
upsf_src_filepath = "#{Chef::Config['file_cache_path']}/#{upsf_src_filename}"
upsf_extract_path = "#{Chef::Config['file_cache_path']}/nginx_upstream_fair_module/#{node['nginx']['upstream_fair']['checksum']}"

remote_file upsf_src_filepath do
  source node['nginx']['upstream_fair']['url']
  checksum node['nginx']['upstream_fair']['checksum']
  owner "root"
  group "root"
  mode 0644
end

bash "extract_upstream_fair_module" do
  cwd ::File.dirname(upsf_src_filepath)
  code <<-EOH
    mkdir -p #{upsf_extract_path}
    tar xzf #{upsf_src_filename} -C #{upsf_extract_path}
    mv #{upsf_extract_path}/*/* #{upsf_extract_path}/
  EOH

  not_if { ::File.exists?(upsf_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{upsf_extract_path}"]
  
