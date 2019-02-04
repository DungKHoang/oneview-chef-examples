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

#---------------------------- Logical Interconnect Group 1-frame
 
# Interconnect Module (ICM) type
icm_40gb    = "Virtual Connect SE 40Gb F8 Module for Synergy" 
icm_20gb    = "Synergy 20Gb Interconnect Link Module" 
icm_10gb    = "Synergy 10Gb Interconnect Link Module" 
icm_fc      = "Virtual Connect SE 16Gb FC Module for Synergy" 
icm_sas     = "Synergy 12Gb SAS Connection Module" 
 
# Data for uplinkset FC-No uplink
lig_1_frame_uplink_FC_No_uplink_data= {
     name:                       "FC-No uplink", 
     mode:                       "Auto", 
     networkType:                "FibreChannel" 
}
lig_1_frame_uplink_FC_No_uplink_networks = ["FC-A"]
lig_1_frame_uplink_FC_No_uplink_connections = [] 
# Data for uplinkset prod-nouplink
lig_1_frame_uplink_prod_nouplink_data= {
     name:                       "prod-nouplink", 
     mode:                       "Auto", 
     ethernetNetworkType:        "Tagged", 
     lacpTimer:                  "Short", 
     networkType:                "Ethernet" 
}
lig_1_frame_uplink_prod_nouplink_networks = ["Production100","Production200"]
lig_1_frame_uplink_prod_nouplink_connections = [] 
 
oneview_logical_interconnect_group  "1-frame-chef" do
     client my_client
     api_variant "Synergy" 
     data(
         redundancyType:         "Redundant",
         enclosureIndexes:       [1],
         interconnectBaySet:     3,
         enclosureType:              "SY12000"
     )
     interconnects [
         { bay: 3, type: icm_40gb, enclosure_index: 1 },
         { bay: 6, type: icm_40gb, enclosure_index: 1 }
     ]
     uplink_sets [
         { data: lig_1_frame_uplink_FC_No_uplink_data, connections: lig_1_frame_uplink_FC_No_uplink_connections, networks: lig_1_frame_uplink_FC_No_uplink_networks },
         { data: lig_1_frame_uplink_prod_nouplink_data, connections: lig_1_frame_uplink_prod_nouplink_connections, networks: lig_1_frame_uplink_prod_nouplink_networks }
     ]
     action  :create_if_missing
end

#---------------------------- Logical Interconnect Group LIG-ETH
 
# Interconnect Module (ICM) type
icm_40gb    = "Virtual Connect SE 40Gb F8 Module for Synergy" 
icm_20gb    = "Synergy 20Gb Interconnect Link Module" 
icm_10gb    = "Synergy 10Gb Interconnect Link Module" 
icm_fc      = "Virtual Connect SE 16Gb FC Module for Synergy" 
icm_sas     = "Synergy 12Gb SAS Connection Module" 
 
# Data for uplinkset Backup
lig_LIG_ETH_uplink_Backup_data= {
     name:                       "Backup", 
     mode:                       "Auto", 
     ethernetNetworkType:        "Tagged", 
     lacpTimer:                  "Short", 
     networkType:                "Ethernet" 
}
lig_LIG_ETH_uplink_Backup_networks = ["Backup-30","SVCluster-1"]
lig_LIG_ETH_uplink_Backup_connections = [ 
     { bay: 3, port: "Q2", type: icm_40gb,  enclosure_index: 1 }, 
     { bay: 3, port: "Q3", type: icm_40gb,  enclosure_index: 1 }, 
     { bay: 6, port: "Q1", type: icm_40gb,  enclosure_index: 2 }, 
     { bay: 6, port: "Q2", type: icm_40gb,  enclosure_index: 2 } 
] 
# Data for uplinkset Prod
lig_LIG_ETH_uplink_Prod_data= {
     name:                       "Prod", 
     mode:                       "Auto", 
     ethernetNetworkType:        "Tagged", 
     lacpTimer:                  "Short", 
     networkType:                "Ethernet" 
}
lig_LIG_ETH_uplink_Prod_networks = ["Production100","Production200"]
lig_LIG_ETH_uplink_Prod_connections = [ 
     { bay: 3, port: "Q5:1", type: icm_40gb,  enclosure_index: 1 }, 
     { bay: 3, port: "Q5:2", type: icm_40gb,  enclosure_index: 1 }, 
     { bay: 6, port: "Q4:1", type: icm_40gb,  enclosure_index: 2 }, 
     { bay: 6, port: "Q4:2", type: icm_40gb,  enclosure_index: 2 } 
] 
 
oneview_logical_interconnect_group  "LIG-ETH-chef" do
     client my_client
     api_variant "Synergy" 
     data(
         redundancyType:         "HighlyAvailable",
         enclosureIndexes:       [1,2,3],
         interconnectBaySet:     3,
         enclosureType:              "SY12000"
     )
     interconnects [
         { bay: 3, type: icm_40gb, enclosure_index: 1 },
         { bay: 6, type: icm_20gb, enclosure_index: 1 },
         { bay: 6, type: icm_40gb, enclosure_index: 2 },
         { bay: 3, type: icm_20gb, enclosure_index: 2 },
         { bay: 6, type: icm_20gb, enclosure_index: 3 },
         { bay: 3, type: icm_20gb, enclosure_index: 3 }
     ]
     uplink_sets [
         { data: lig_LIG_ETH_uplink_Backup_data, connections: lig_LIG_ETH_uplink_Backup_connections, networks: lig_LIG_ETH_uplink_Backup_networks },
         { data: lig_LIG_ETH_uplink_Prod_data, connections: lig_LIG_ETH_uplink_Prod_connections, networks: lig_LIG_ETH_uplink_Prod_networks }
     ]
     action  :create_if_missing
end

#---------------------------- Logical Interconnect Group LIG-FC
 
# Interconnect Module (ICM) type
icm_40gb    = "Virtual Connect SE 40Gb F8 Module for Synergy" 
icm_20gb    = "Synergy 20Gb Interconnect Link Module" 
icm_10gb    = "Synergy 10Gb Interconnect Link Module" 
icm_fc      = "Virtual Connect SE 16Gb FC Module for Synergy" 
icm_sas     = "Synergy 12Gb SAS Connection Module" 
 
# Data for uplinkset FC-A
lig_LIG_FC_uplink_FC_A_data= {
     name:                       "FC-A", 
     mode:                       "Auto", 
     networkType:                "FibreChannel" 
}
lig_LIG_FC_uplink_FC_A_networks = ["FC-A"]
lig_LIG_FC_uplink_FC_A_connections = [ 
     { bay: 2, port: "1", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 2, port: "2", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 2, port: "3", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 2, port: "4", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 2, port: "5", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 2, port: "6", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 2, port: "7", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 2, port: "8", type: icm_fc,  enclosure_index: -1 } 
] 
# Data for uplinkset FC-B
lig_LIG_FC_uplink_FC_B_data= {
     name:                       "FC-B", 
     mode:                       "Auto", 
     networkType:                "FibreChannel" 
}
lig_LIG_FC_uplink_FC_B_networks = ["FC-B"]
lig_LIG_FC_uplink_FC_B_connections = [ 
     { bay: 5, port: "1", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 5, port: "2", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 5, port: "3", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 5, port: "4", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 5, port: "5", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 5, port: "6", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 5, port: "7", type: icm_fc,  enclosure_index: -1 }, 
     { bay: 5, port: "8", type: icm_fc,  enclosure_index: -1 } 
] 
 
oneview_logical_interconnect_group  "LIG-FC-chef" do
     client my_client
     api_variant "Synergy" 
     data(
         redundancyType:         "Redundant",
         enclosureIndexes:       [-1],
         interconnectBaySet:     2,
         enclosureType:              "SY12000"
     )
     interconnects [
         { bay: 2, type: icm_fc, enclosure_index: -1 },
         { bay: 5, type: icm_fc, enclosure_index: -1 }
     ]
     uplink_sets [
         { data: lig_LIG_FC_uplink_FC_A_data, connections: lig_LIG_FC_uplink_FC_A_connections, networks: lig_LIG_FC_uplink_FC_A_networks },
         { data: lig_LIG_FC_uplink_FC_B_data, connections: lig_LIG_FC_uplink_FC_B_connections, networks: lig_LIG_FC_uplink_FC_B_networks }
     ]
     action  :create_if_missing
end


 
#---------------------------- Logical Interconnect Group LIG-SAS-chef
 
# Interconnect Module (ICM) type
icm_40gb    = "Virtual Connect SE 40Gb F8 Module for Synergy" 
icm_20gb    = "Synergy 20Gb Interconnect Link Module" 
icm_10gb    = "Synergy 10Gb Interconnect Link Module" 
icm_fc      = "Virtual Connect SE 16Gb FC Module for Synergy" 
icm_sas     = "Synergy 12Gb SAS Connection Module" 
 
oneview_sas_logical_interconnect_group  "LIG-SAS-chef" do
     client my_client
     api_variant "Synergy" 
     interconnects [
         { bay: 4, type: icm_sas, enclosure_index: 1 },
         { bay: 1, type: icm_sas, enclosure_index: 1 }
     ]
     action  :create_if_missing
end
 
