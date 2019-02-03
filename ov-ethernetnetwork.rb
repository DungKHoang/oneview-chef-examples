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

oneview_ethernet_network "Backup-30" do
     client my_client
     data(
         vlanId:                 30,
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 20000
         }
         ethernetNetworkType:    "Tagged",
         purpose:                "General",
         smartLink:              true,  
         privateNetwork:         false   
     )
     action  :create_if_missing
end
 
 
oneview_ethernet_network "Production100" do
     client my_client
     data(
         vlanId:                 100,
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 20000
         }
         ethernetNetworkType:    "Tagged",
         purpose:                "General",
         smartLink:              false,  
         privateNetwork:         false   
     )
     action  :create_if_missing
end
 
oneview_ethernet_network "Production200" do
     client my_client
     data(
         vlanId:                 200,
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 20000
         }
         ethernetNetworkType:    "Tagged",
         purpose:                "General",
         smartLink:              false,  
         privateNetwork:         false   
     )
     action  :create_if_missing
end
 

