#!/bin/bash

NETWORK="eno1"

RED="\033[1;31m" 
GREEN="\033[1;32m"
PURPLE="\033[1;35m"
NC="\033[0m"

# shekan.ir DNS
DNS="178.22.122.100,185.51.200.2" 
# electrotm.org DNS
#DNS="78.157.42.101,78.157.42.100" 
# 403.online DNS
#DNS="10.202.10.202,10.202.10.102" 

DEVICE=$(nmcli -t -f NAME,DEVICE con show | grep ${NETWORK}  | sed 's/:.*//')
	
# Function to turn off network
turn_off_network() {
    echo -e "${RED}Turning off network interfaces...${NC}"
    if ip link show ${NETWORK} | grep -q "state UP"; then
         nmcli dev disconnect ${NETWORK}
    else
        echo "${NETWORK} is not connected. Skipping network disconnect."
    fi
}

# Function to set DNS to auto
set_dns_to_auto() {
    echo -e "Checking current DNS configuration..."

	IGNORE_AUTO_DNS=$(nmcli con show ${DEVICE} | grep -i ipv4.ignore-auto-dns | awk '{print $2}')

	if [[ "$IGNORE_AUTO_DNS" == "yes" ]]; then
	    # Set DNS to automatic by modifying the connection settings
	     nmcli con mod "${DEVICE}" ipv4.dns ""
	     nmcli con mod "${DEVICE}" ipv4.ignore-auto-dns no
	    echo -e "${PURPLE}DNS set to automatic.${NC}"
	else
	    # Set DNS to manual and apply custom DNS
	     nmcli con mod "${DEVICE}" ipv4.ignore-auto-dns yes
	     nmcli con mod "${DEVICE}" ipv4.dns "${DNS}"
	    echo -e "${PURPLE}Custom DNS set.${NC}"
	fi
}

# Function to turn on network
turn_on_network() {
    echo -e "${GREEN}Turning on network interfaces...${NC}"
    sleep 3
    if ip link show ${NETWORK} | grep -q "state DOWN"; then
         ip link set ${NETWORK} up
    fi
     nmcli dev connect ${NETWORK}
}

turn_off_network
set_dns_to_auto
turn_on_network
# Main script execution
echo "Starting DNS configuration script..."
