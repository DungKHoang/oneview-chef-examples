###
# Copyright (2016-2017) Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###

my_client = {
    url: ENV['ONEVIEWSDK_URL'],
    user: ENV['ONEVIEWSDK_USER'],
    password: ENV['ONEVIEWSDK_PASSWORD'],
    api_version: 300
}

oneview_network_set "ns-Production" do
     client my_client
     native_network "Production100" 
     ethernet_network_list ["Production100","Production200"] 
     data(
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 10000
         }
     )
     action  :create_if_missing
end
 
 
oneview_network_set "ns-VLAN" do
     client my_client
     ethernet_network_list ["vLAN2260-A","vLAN2261-B"] 
     data(
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 10000
         }
     )
     action  :create_if_missing
end
 
