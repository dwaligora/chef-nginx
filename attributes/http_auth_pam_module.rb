#
# Cookbook Name:: nginx
# Attributes:: http_auth_pam_module
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

default['nginx']['http_auth_pam']['url']      = "http://web.iti.upv.es/~sto/nginx/ngx_http_auth_pam_module-1.2.tar.gz"
default['nginx']['http_auth_pam']['checksum'] = "3f6322663c6479a7b6b974bfa7417e5c"
