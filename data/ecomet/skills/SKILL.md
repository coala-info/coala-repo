---
name: ecomet
description: The ecomet tool manages and monitors I2C-connected hardware modules and sensors on single-board computers. Use when user asks to detect I2C devices, configure environmental sensors, manage power units, or interface with hardware drivers like LEDs and EEPROMs.
homepage: https://github.com/mamin27/ecomet_i2c_raspberry_tools
metadata:
  docker_image: "biocontainers/ecomet:phenomenal-v1.1_cv0.3.39"
---

# ecomet

## Overview

The ecomet skill facilitates the management and monitoring of I2C-connected hardware modules on single-board computers. It leverages the ecomet-i2c-sensors framework to provide a high-level interface for a diverse range of components, including environmental sensors (temperature, humidity, pressure, air quality), power management units, EEPROMs, and motor/LED drivers. This skill is essential for developers building IoT applications or hardware prototypes who need to quickly detect devices on the I2C bus and interface with them using standardized Python drivers.

## Installation and Setup

To use the ecomet tools, the Python library must be installed on the target system:

- Install via pip: `pip install ecomet-i2c-sensors`
- Install requirements for local development: `pip3 install -r requirements.txt --user`

## Device Detection

Before interfacing with specific sensors, verify the hardware connection using the ecomet detection utility. This tool is an alternative to the standard `i2cdetect` and is optimized for the ecomet ecosystem.

- Run the detection script: `python3 bin/i2c_ecomet_detect.py`

## Configuration Best Practices

The library looks for a configuration file located at `~/.comet/config.yaml`. While you should not generate YAML code blocks here, ensure the following parameters are defined within that file for proper operation:

- **I2C Bus**: Specify the active bus (e.g., `i2c-1` or `i2c-3`) under the `smb` parameter.
- **EEPROM Settings**: Define the chip type (e.g., '24c02'), the hex slave address (e.g., 0x50), and the `writestrobe` GPIO pin used for write protection.
- **Sensor Thresholds**: For sensors like the MS5637 (pressure) or SN-GCJA5 (PM sensor), define `min` and `max` intervals to ensure the library only accepts valid data ranges.
- **HDC1080 Specifics**: Configure the `measure_mode` ('only' or 'both'), `heating` status, and bit resolution for temperature and humidity.

## Supported Hardware Modules

The skill provides procedural knowledge for the following categories:

- **Environmental**: HDC1080/HTU21D (Temp/Humid), MS5637 (Pressure/Altimeter), SGP40 (VOC), SN-GCJA5 (Laser PM).
- **Power & Current**: INA226/INA260 (Current/Power), AXP209 (PMU), ISL2802x.
- **Drivers & Displays**: PCA9632 (4-bit PWM LED/Motor), SSD1306/SSD1309 (OLED Displays), PCA9557 (I/O Expander).
- **Specialized**: AS3935 (Lightning Sensor), TSL25911 (Ambient Light), EMC2301 (PWM Fan Controller).

## Expert Tips

- **Write Protection**: When working with EEPROMs, the `writestrobe` parameter is critical; it must point to the physical GPIO pin connected to the WP (Write Protect) pin of the chip.
- **Bus Monitoring**: Use the `smb_detect` parameter in your configuration to limit the range of I2C addresses scanned by the detection tools, which can prevent interference with sensitive legacy hardware.
- **Driver Compatibility**: Note that the HDC1080 driver was significantly rewritten in version 0.1.10; ensure legacy scripts are updated to use the new method calls.

## Reference documentation

- [ecomet_i2c_raspberry_tools Main Repository](./references/github_com_mamin27_ecomet_i2c_raspberry_tools.md)
- [ecomet Wiki and Hardware Info](./references/github_com_mamin27_ecomet_i2c_raspberry_tools_wiki.md)