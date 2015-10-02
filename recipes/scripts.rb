#
# Cookbook Name:: elasticsearch-cluster
# Recipe:: scripts
#
# Copyright 2015, Virender Khatri
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

node['elasticsearch']['scripts'].each do |script, options|
  elasticsearch_script script do
    cookbook options['cookbook'] if options.key?('cookbook')
    source options['source'] if options.key?('source')
    action options['action'] if options.key?('action')
  end
end
