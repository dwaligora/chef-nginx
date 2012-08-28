#
# Cookbook Name:: nginx
# Attributes:: mod_h264_streaming
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

default['nginx']['mod_h264_streaming']['url']      = "http://h264.code-shop.com/download/nginx_mod_h264_streaming-2.2.7.tar.gz"
default['nginx']['mod_h264_streaming']['checksum'] = "c7eda1cd66b0ee8b713ec828ee6a7894"
