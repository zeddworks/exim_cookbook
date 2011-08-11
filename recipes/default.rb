#
# Cookbook Name:: exim
# Recipe:: default
#
# Copyright 2011, ZeddWorks
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

package "exim" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "exim4" },
    ["redhat"] => { "default" => "exim4" }
  )
end

smtp = Chef::EncryptedDataBagItem.load("apps", "#{node[:brand]}_smtp")

template "/etc/exim4/update-exim4.conf.conf" do
  source "update-exim4.conf.conf.erb"
  variables({
    :domain => smtp["domain"],
    :smtp_host => smtp["smtp_host"]
  })
end

execute "update-exim4.conf"
