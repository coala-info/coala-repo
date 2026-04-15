---
name: lsc
description: lsc is a menu-driven automation framework for Kali Linux that streamlines penetration testing workflows and tool management. Use when user asks to automate WiFi auditing, spoof MAC addresses, generate Metasploit payloads, or install and launch various security tools.
homepage: https://github.com/arismelachroinos/lscript
metadata:
  docker_image: "quay.io/biocontainers/lsc:2.0--py27pl5.22.0_0"
---

# lsc

## Overview
lsc (Lazy Script) is a menu-driven automation framework for Kali Linux designed to streamline complex penetration testing workflows. It acts as a centralized hub for installing, configuring, and launching dozens of specialized security tools. By providing a simplified interface for tasks like WiFi handshake capture, MAC address manipulation, and payload generation, it allows practitioners to execute multi-step procedures with minimal manual command entry.

## Usage Guidelines

### Core Execution
The script is designed for speed and minimal typing. Once installed, it is typically invoked with a single character:
- Start the interface: `l`
- Note: You must have root privileges to run the script and its associated tools.

### Key Functional Commands
Within the lsc environment, use these specific triggers to access core features:
- **ks**: Access and set custom keyboard shortcuts to launch your most-used tools instantly.
- **update**: Update the script and its tool database to the latest version.
- **Anonymize**: Quickly toggle anonymity settings and view your public IP.
- **Interfaces**: Enable or disable wireless interfaces and change MAC addresses.

### Tool Management
lsc serves as a package manager for pentesting tools. You can install and launch the following categories of tools directly from the menu:
- **WiFi Penetration**: Fluxion, Wifite, Wifiphisher, Airgeddon, Fern Wifi Cracker.
- **Exploitation**: Metasploit (automated payload/listener creation), BeEF, Routersploit.
- **Information Gathering**: ReconDog, RED HAWK, Infoga, Angry IP Scanner.
- **Web Hacking**: SQLmap (automated), NoSQLMap, LFISuite.

### Common Workflows
1. **WiFi Auditing**: Navigate to the WiFi section to automate WPA/WPA2 handshake capture or WPS pin cracking.
2. **MAC Spoofing**: Use the interface tools to rotate your MAC address before starting an engagement.
3. **Metasploit Automation**: Use the script to generate payloads and automatically set up corresponding listeners, saving the configurations for future use.

## Expert Tips
- **Hidden Shortcuts**: Check the `ks` menu for hidden shortcuts, such as automated EternalBlue exploitation.
- **Installation**: If a tool fails to launch, use the internal lsc installer to ensure all dependencies and paths are correctly configured for the Kali environment.
- **Persistence**: Use the "save listeners" feature in the Metasploit section to quickly resume work after a reboot or session timeout.

## Reference documentation
- [Lazy Script Repository Overview](./references/github_com_arismelachroinos_lscript.md)
- [Issues and Troubleshooting](./references/github_com_arismelachroinos_lscript_issues.md)