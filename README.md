# DNS Configuration Script

This Bash script is designed to manage network configurations, particularly focusing on enabling/disabling a network interface and setting custom DNS servers. It simplifies the process of applying specific DNS configurations or reverting to automatic DNS settings.

## Features

- Automatically disconnects the specified network interface.
- Configures DNS settings:
  - Switches between custom DNS and automatic DNS settings.
- Reconnects the network interface after configuration.
- Includes predefined DNS options:
  - **Shekan.ir**: `178.22.122.100, 185.51.200.2`
  - **Electrotm.org**: `78.157.42.101, 78.157.42.100`
  - **403.online**: `10.202.10.202, 10.202.10.102`

## Prerequisites

- Linux system with `nmcli` (NetworkManager CLI) installed and active.
- Proper permissions to execute network-related commands (may require `sudo`).
- Network interface name (default is `eno1`).

## Usage

1. Clone or copy the script to your system.

2. **Find Your Network Interface Name**:
   - Run the following command to list your network interfaces:
     ```bash
     ip link show
     ```
   - Identify your active network interface (e.g., `eno1`, `eth0`, or `wlan0`).

3. **Edit the Script**:
   - Open the `ubuntu-dns.sh` file in a text editor:
     ```bash
     nano ubuntu-dns.sh
     ```
   - Locate the `NETWORK` variable at the top of the script:
     ```bash
     NETWORK="eno1"
     ```
   - Replace `eno1` with your network interface name and save the file.

4. **Run the Script**:
   - Grant execute permissions to the script:
     ```bash
     chmod +x ubuntu-dns.sh
     ```
   - Run the script with `sudo`:
     ```bash
     sudo ./ubuntu-dns.sh
     ```

## Example Output

```bash
Turning off network interfaces...
Checking current DNS configuration...
Custom DNS set.
Turning on network interfaces...

