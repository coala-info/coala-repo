---
name: ctn-dev
description: This tool assists in the setup, configuration, and calibration of the Phoenix Flight Controller for Teensy 3.0 hardware. Use when user asks to map hardware pins, select flight kinematics, or perform accelerometer trimming using manual stick commands.
homepage: https://github.com/cTn-dev/Phoenix-FlightController
metadata:
  docker_image: "biocontainers/ctn-dev:v3.2.0dfsg-5-deb_cv1"
---

# ctn-dev

## Overview
The Phoenix Flight Controller is a specialized system designed for Search and Rescue (SAR) operations, built on the K20DX128 (Teensy 3.0) platform. This skill assists in the setup, configuration, and calibration of the flight controller, specifically focusing on hardware pinouts, kinematics selection, and the manual stick-command interface used for accelerometer trimming without a computer.

## Hardware Configuration and Pin Mapping
When setting up the Teensy 3.0 for Phoenix-FC, use the following hardware pin assignments:

- **Communication**: I2C SCL (19), I2C SDA (18).
- **Input**: PPM/PWM Receiver (3).
- **Motor Outputs (Rotors 1-8)**: 22, 23, 9, 10, 6, 20, 21, 5.
- **Indicators**: Orientation/Armed-Disarmed lights (14).
- **Monitoring**: Battery/Current Sensor (17).

## Flight Dynamics and Kinematics
- **Update Rates**: The system processes raw sensor data at 1000Hz (1ms) and kinematics at 100Hz (10ms).
- **ESC Signal**: Uses an 8-channel FLEX timer. The default update rate is 400Hz, though 250Hz is supported.
- **Kinematics Selection**: 
    - **CMP**: Default proprietary kinematics.
    - **ARG**: Aeroquad-based kinematics (requires include change).
    - **DCM**: FreeIMU-based kinematics.
- **Flight Modes**:
    - **Rate (ACRO)**: Gyro only.
    - **Attitude**: Gyro with accelerometer corrections.
    - **Altitude Hold**: Requires barometer or sonar.

## Accelerometer Trimming (Stick Commands)
Calibration is performed via the Transmitter (TX) while the craft is in a **dis-armed** state.

1. **Enter Trimming Mode**: Move Throttle stick UP and Rudder stick LEFT.
2. **Adjust Values**: 
    - Use PITCH (Up/Down) to adjust pitch offset.
    - Use ROLL (Left/Right) to adjust roll offset.
3. **Save to EEPROM**: Move Throttle stick UP and Rudder stick RIGHT.
4. **Exit Mode**: Move Throttle stick DOWN.

## Best Practices
- **Sensor Filtering**: Initial raw data is averaged. If experiencing "bouncy" landings, ensure the latest firmware patches for temperature handling on the MPU and UI refresh logic are applied.
- **Safety**: The firmware initializes all bits to 0 for safety during startup. Always verify motor rotation directions before attaching propellers.
- **Backup**: Use the configurator's backup/restore feature to save EEPROM settings; backup files are timestamped by default.

## Reference documentation
- [Phoenix-FlightController README](./references/github_com_cTn-dev_Phoenix-FlightController.md)
- [Commit History and Workarounds](./references/github_com_cTn-dev_Phoenix-FlightController_commits_master.md)