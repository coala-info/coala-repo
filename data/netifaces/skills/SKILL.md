---
name: netifaces
description: The netifaces tool provides a portable way to access network interface information and routing gateways on a local machine. Use when user asks to list network interfaces, retrieve IP or MAC addresses for a specific interface, or identify system default gateways.
homepage: https://github.com/al45tair/netifaces
metadata:
  docker_image: "quay.io/biocontainers/netifaces:0.10.4--py36_1"
---

# netifaces

## Overview

The `netifaces` skill provides a portable method for accessing the network configuration of the local machine. Because low-level networking APIs are highly system-dependent, `netifaces` abstracts these differences into a consistent Python API. It allows you to enumerate all network interfaces, inspect the specific address details for each (including peer addresses for point-to-point links), and identify the system's routing gateways.

## Usage Instructions

### 1. Enumerating Interfaces
To get a list of all available network interface identifiers on the system:

```python
import netifaces
interfaces = netifaces.interfaces()
# Returns e.g., ['lo0', 'eth0', 'wlan0']
```

### 2. Retrieving Interface Addresses
Use `ifaddresses()` to get a dictionary of addresses associated with a specific interface. The dictionary is keyed by address family.

**Important:** Always use the module's constants for address families, as the underlying integer values are system-dependent.

*   `netifaces.AF_LINK`: Link layer (MAC address)
*   `netifaces.AF_INET`: IPv4
*   `netifaces.AF_INET6`: IPv6

```python
addrs = netifaces.ifaddresses('eth0')

# Get IPv4 information
if netifaces.AF_INET in addrs:
    ipv4_info = addrs[netifaces.AF_INET]
    # Note: This is a list, as one interface can have multiple addresses
    for addr in ipv4_info:
        print(f"IP: {addr['addr']}, Netmask: {addr['netmask']}")
```

### 3. Finding Gateways
The `gateways()` function provides access to the system's routing table.

```python
gws = netifaces.gateways()

# Get the default IPv4 gateway
default_gw = gws.get('default', {}).get(netifaces.AF_INET)
if default_gw:
    gateway_ip, interface_name = default_gw
```

## Expert Tips and Best Practices

*   **Handle Multiple Addresses:** Never assume an interface has only one IP address. `ifaddresses()` returns a list of dictionaries for each family. Always iterate through the list or select the appropriate index based on your requirements.
*   **Point-to-Point Links:** For loopback or VPN interfaces, the address dictionary may contain a `peer` key instead of a `broadcast` key.
*   **MAC Address Variations:** `AF_LINK` addresses (MAC addresses) are not always Ethernet. On macOS, for example, FireWire interfaces will return longer hardware addresses.
*   **Missing Data:** Not all keys (like `netmask` or `broadcast`) are guaranteed to be present for every interface or platform. Use `.get()` or check for key existence to prevent `KeyError`.
*   **Archived Status:** Note that the original `netifaces` repository is archived. While the API remains a standard for these tasks, ensure the environment has the necessary build tools (C compiler) for installation from source, or use pre-built wheels.

## Reference documentation
- [netifaces README](./references/github_com_al45tair_netifaces.md)