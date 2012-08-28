#
# Cookbook Name:: nginx
# Attributes:: upstream_fair
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

default['nginx']['upstream_fair']['url']      = "http://github.com/gnosek/nginx-upstream-fair/tarball/master"
default['nginx']['upstream_fair']['checksum'] = "ac5e7f485476af70e0ee1c52016cddaf"
