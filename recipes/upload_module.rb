#
# Cookbook Name:: nginx
# Recipe:: upload_module
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

uplm_src_filename = ::File.basename(node['nginx']['upload']['url'])
uplm_src_filepath = "#{Chef::Config['file_cache_path']}/#{uplm_src_filename}"
uplm_extract_path = "#{Chef::Config['file_cache_path']}/nginx_upload_module/#{node['nginx']['upload']['checksum']}"

remote_file uplm_src_filepath do
  source node['nginx']['upload']['url']
  checksum node['nginx']['upload']['checksum']
  owner "root"
  group "root"
  mode 0644
end

bash "extract_upload_module" do
  cwd ::File.dirname(uplm_src_filepath)
  code <<-EOH
    mkdir -p #{uplm_extract_path}
    tar xzf #{uplm_src_filename} -C #{uplm_extract_path}
    mv #{uplm_extract_path}/*/* #{uplm_extract_path}/
  EOH

  not_if { ::File.exists?(uplm_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{uplm_extract_path}"]
  
