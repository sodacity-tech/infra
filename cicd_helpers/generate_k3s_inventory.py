import os
import json
import yaml

# initialize k3s inventory's structure & known inventory vars
k3s_inventory = {
    "k3s_cluster": {
        "vars": {
            "ansible_port": 2222,
            "ansible_user": "soda",
            "k3s_version": "v1.30.2+k3s1",
            "api_endpoint": "{{hostvars[groups.server[0]].ansible_host|default(groups.server[0])}}",
        },
        "children": {"server": {"hosts": {}}, "agent": {"hosts": {}}},
    },
}

# get list of VM IPs from VM_IPV4S_JSON environment variable
vm_ipv4s = json.loads(os.getenv("VM_IPV4S_JSON"))

# the first VM in the list will always be designated as a 'server' node
k3s_inventory["k3s_cluster"]["children"]["server"]["hosts"][vm_ipv4s[0]] = None

# the remaining VMs in the list will always be designated as 'agent' nodes
for vm_ipv4 in vm_ipv4s[1:]:
    k3s_inventory["k3s_cluster"]["children"]["agent"]["hosts"][vm_ipv4] = None

# write the inventory to a file
with open("inventory.yml", "w") as f:
    yaml.dump(k3s_inventory, f)
