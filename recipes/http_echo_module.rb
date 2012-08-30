#
# Cookbook Name:: nginx
# Recipe:: http_echo_module
#
# Author:: Danial Pearce (<danial@cushycms.com>)
#
# Copyright 2012, CushyCMS
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

nginx_contrib_module "echo" do
  url       node['nginx']['echo']['url']
  checksum  node['nginx']['echo']['checksum']
end
