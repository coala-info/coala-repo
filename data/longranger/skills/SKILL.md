---
name: longranger
description: The longranger tool transforms a long-range HID reader into a wireless badge-cloning device by integrating it with a Raspberry Pi to capture and host RFID data. Use when user asks to configure Wiegand hardware connections, install the listener software, or retrieve captured badge credentials via the local web interface.
homepage: https://github.com/linuz/LongRangeReader
---


# longranger

## Overview
The longranger skill provides procedural knowledge for transforming a standard HID Prox or iCLASS long-range reader into a wireless badge-cloning device. By integrating a Raspberry Pi Zero W with the reader's Wiegand output, the system captures badge data and hosts it on a local web server. This skill guides you through the hardware integration, the initial software bootstrap, and the network configuration required to retrieve captured RFID credentials.

## Hardware Configuration
The system relies on specific GPIO mapping to interpret Wiegand protocol signals from the HID reader.

- **Data0 (Green Wire)**: Connect to Raspberry Pi Pin 8 (GPIO 14).
- **Data1 (White Wire)**: Connect to Raspberry Pi Pin 10 (GPIO 15).
- **Power (Pi)**: Connect 5V DC to Pin 02 and Ground to Pin 06.
- **Power (Reader)**: Requires 12V DC. If using an 18650 battery source, use a DC-DC Boost Converter to reach 12V for the reader and a Buck Converter to reach 5V for the Pi.

## Installation and Setup
The software environment must be initialized on a clean installation of Raspbian Lite.

1. **Clone and Prepare**: Ensure the project files are present on the Pi.
2. **Execution**: Run the setup script with root privileges to configure the environment and dependencies:
   ```bash
   sudo ./setup.sh
   ```
3. **Automatic Start**: After setup, the system is designed to boot into Access Point (AP) mode and start the listener and web server scripts (`lrr_wiegand_listener.py` and `lrr_webserver.py`) automatically.

## Operation and Data Retrieval
Once powered, the device creates a standalone wireless network for data exfiltration.

- **SSID**: `LongRangeReader`
- **WPA Key**: `accessgranted`
- **Gateway IP**: `192.168.3.1`

To view captured badges, connect a client device to the "LongRangeReader" WiFi and navigate to `http://192.168.3.1` in a web browser. The interface will automatically populate with scanned RFID card data as they are read.

## Troubleshooting and Best Practices
- **Interference**: If range is significantly lower than the reader's rated distance, check for electromagnetic interference or insufficient current from the battery source (the system requires a source capable of at least 3A).
- **Voltage Levels**: Ensure the Wiegand data lines are operating at voltages compatible with the Raspberry Pi GPIO (3.3V). Some older readers may output 5V on data lines, which requires a level shifter or voltage divider to prevent damage to the Pi.
- **Service Status**: If the web page does not load, verify that `lrr_webserver.py` is running and bound to the correct wireless interface.

## Reference documentation
- [Long Range Reader README](./references/github_com_linuz_LongRangeReader.md)
- [Project Issues and Troubleshooting](./references/github_com_linuz_LongRangeReader_issues.md)