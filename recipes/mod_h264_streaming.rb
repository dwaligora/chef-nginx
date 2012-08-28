#
# Cookbook Name:: nginx
# Recipe:: mod_h264_streaming
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

mh264_src_filename = ::File.basename(node['nginx']['mod_h264_streaming']['url'])
mh264_src_filepath = "#{Chef::Config['file_cache_path']}/#{mh264_src_filename}"
mh264_extract_path = "#{Chef::Config['file_cache_path']}/nginx_mod_h264_streaming_module/#{node['nginx']['mod_h264_streaming']['checksum']}"

remote_file mh264_src_filepath do
  source node['nginx']['mod_h264_streaming']['url']
  checksum node['nginx']['mod_h264_streaming']['checksum']
  owner "root"
  group "root"
  mode 0644
end

bash "extract_mod_h264_streaming_module" do
  cwd ::File.dirname(mh264_src_filepath)
  code <<-EOH
    mkdir -p #{mh264_extract_path}
    tar xzf #{mh264_src_filename} -C #{mh264_extract_path}
    mv #{mh264_extract_path}/*/* #{mh264_extract_path}/
  EOH

  not_if { ::File.exists?(mh264_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{mh264_extract_path}"]
  
