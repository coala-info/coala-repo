---
name: prank
description: NEMO is a specialized firmware suite for the M5Stack ecosystem that enables portable digital self-defense, wireless auditing, and security-oriented pranks. Use when user asks to deploy WiFi captive portals, perform Bluetooth notification spamming, trigger universal IR power-off codes, or detect suspicious BadUSB devices.
homepage: https://github.com/n0xa/m5stick-nemo
metadata:
  docker_image: "quay.io/biocontainers/prank:170427--h4ac6f70_0"
---

# prank

## Overview
NEMO is a specialized firmware suite designed for the M5Stack ecosystem that enables portable digital self-defense and security-oriented pranks. It leverages the ESP32's wireless and IR capabilities to perform tasks ranging from TV control and Bluetooth notification spamming to sophisticated WiFi captive portals. This skill provides the procedural knowledge required to navigate the interface, deploy specific attack modules, and utilize hardware-specific features like the BadUSB Hunter.

## Operational Guidance

### Hardware Controls
Navigation varies by device. Use these mappings to operate the firmware:
- **M5StickC / StickC-Plus**:
  - **Home**: Tap the power button (near the USB port).
  - **Next**: Tap the side button.
  - **Select**: Tap the large M5 button on the front.
  - **Power Off**: Long-press the power button for 6 seconds.
- **Cardputer**:
  - **Home**: Esc or Left-Arrow key.
  - **Next/Prev**: Down-Arrow and Up-Arrow keys.
  - **Select**: OK/Enter or Right-Arrow key.

### Wireless Auditing and Attacks
- **NEMO Portal**: Deploy a "Nemo Free WiFi" hotspot to demonstrate social engineering.
  - Access captured credentials at `http://172.0.0.1/creds`.
  - Change the portal SSID at `http://172.0.0.1/ssid`.
  - Use an SD card (FAT formatted) on supported devices to log credentials to `nemo-portal-creds.txt`.
- **WiFi Spam**: Use "Random mode" to generate hundreds of SSIDs per minute for environmental noise or "WiFi Rickrolling."
- **Hunter Modes**: Use BLE Hunter, Deauth Hunter, and PineAP Hunter for situational awareness of ongoing wireless attacks in the immediate vicinity.

### Hardware Security Testing
- **BadUSB Hunter**: Exclusively for Cardputer and ADV models.
  - Connect unknown USB peripherals via a USB-C OTG adapter.
  - **Status Indicators**:
    - **Device OK**: No suspicious HID profiles detected.
    - **HID-Only**: Device presents as a mouse/keyboard (potential risk).
    - **!SUSPICIOUS!**: Device has multiple interface profiles or known BadUSB signatures.
  - **Power Tip**: If a device fails to enumerate, slide the Grove port switch to "5V In" and provide external power to ensure the USB-C port delivers full voltage.

### Infrared and Bluetooth
- **TV B-Gone**: Point the device's IR transmitter at displays or projectors to trigger universal power-off codes.
- **Spamming**: Use AppleJuice for iOS pairing pop-ups or SwiftPair for Windows/Android notification flooding.

## Best Practices
- **Battery Management**: Use the settings menu to adjust brightness and enable automatic dimming to extend field life.
- **SSID Cloning**: Use the WiFi SSID Scanner first to identify local networks, then clone a target SSID directly into the NEMO Portal for more effective social engineering demonstrations.
- **Persistence**: Settings for screen rotation, brightness, and Portal SSIDs are backed by EEPROM and will persist across reboots.

## Reference documentation
- [M5Stick-NEMO Main README](./references/github_com_n0xa_m5stick-nemo.md)
- [NEMO Wiki](./references/github_com_n0xa_m5stick-nemo_wiki.md)