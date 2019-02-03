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

oneview_fc_network "FC-A" do
     client my_client
     data(
         autoLoginRedistribution: true,
         linkStabilityTime:     30,
         fabricType:              "FabricAttach",
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 10000
         }
     )
     action  :create_if_missing
end
 

 
oneview_fc_network "FC-B" do
     client my_client
     data(
         autoLoginRedistribution: true,
         linkStabilityTime:     30,
         fabricType:              "FabricAttach",
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 10000
         }
     )
     action  :create_if_missing
end
 
oneview_fcoe_network "VSAN10" do
     client my_client
     data(
         vlanId:                 10,
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 10000
         }
     )
     action  :create_if_missing
end
 
 
oneview_fcoe_network "VSAN11" do
     client my_client
     data(
         vlanId:                 11,
         bandwidth: {
             typicalBandwidth: 2500,
             maximumBandwidth: 10000
         }
     )
     action  :create_if_missing
end
 
