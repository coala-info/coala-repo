---
name: galileo
description: Provides information and configuration details for the Galileo 2 3D printer extruder and Z-driver projects. Use when user asks to understand Galileo 2 specifications, Klipper configuration, or reseller information.
homepage: https://github.com/JaredC01/Galileo2
metadata:
  docker_image: "biocontainers/galileo:v0.5.1-6-deb_cv1"
---

# galileo

yaml
name: galileo
description: |
  Provides information and configuration details for the Galileo 2 3D printer extruder and Z-driver projects.
  Use when Claude needs to understand the specifications, Klipper configuration, or reseller information for Galileo 2 components.
```
## Overview
The Galileo 2 skill provides information about the Galileo 2 3D printer extruder and Z-driver projects. This includes details on the different components (G2E, G2Z, G2SA), their design benefits, Klipper configuration settings, and a list of authorized resellers. It is useful for users who are looking to understand or implement these specific 3D printer hardware modifications.

## Instructions for using Galileo 2 information

This skill is designed to provide information about the Galileo 2 3D printer extruder and Z-driver projects. It does not involve direct command-line tool usage but rather provides reference information.

### Understanding Galileo 2 Components

The Galileo 2 project encompasses several variants:
*   **G2E (Galileo 2 Extruder):** A drop-in extruder for Voron Stealthburner.
*   **G2Z (Galileo 2 Z-Drivers):** For V2-style printers (including V2, Micron, etc.).
*   **G2SA (Galileo 2 Standalone Extruder):** With mounting options for Orbiter-2.0-style or Sherpa-Mini-style mounts.

### Key Design Benefits of Galileo 2 over Galileo 1:
*   Full redesign with a 9:1 gear ratio.
*   Optimized gearbox design.
*   Custom 9T stepper with a taller spur gear for increased contact surface area, improved wear, and power transfer.
*   Proper gear meshing due to the number of stepper teeth being divisible by the number of planets (9T sun / 3 planets), leading to even loading and improved wear characteristics.

### Klipper Configuration Settings

When installing Galileo 2 components, it is crucial to update your Klipper configuration.

#### For G2 Extruders (G2E and G2SA):
You must update both `gear_ratio` and `rotation_distance` in your Klipper configuration and perform a standard extruder calibration. The `run_current` will also need adjustment.

Example Klipper configuration snippet:
```ini
[extruder]
rotation_distance: 47.088
gear_ratio: 9:1
microsteps: 16

[tmc2209 extruder]
run_current: 0.6
```

#### For G2 Z Drivers (G2Z):
You must update both `gear_ratio` and `rotation_distance` in your Klipper configuration. The `run_current` will also need adjustment.

Example Klipper configuration snippet:
```ini
[stepper_z]
rotation_distance: 40
gear_ratio: 9:1
microsteps: 32

[tmc2209 stepper_z]
run_current: 0.8
```

### Resellers

Only kits sold by LDO are considered "official" Galileo 2 kits. A list of authorized resellers is available.



## Subcommands

| Command | Description |
|---------|-------------|
| galileo | synchronize Fitbit trackers with Fitbit web service |
| galileo | synchronize Fitbit trackers with Fitbit web service |
| galileo | synchronize Fitbit trackers with Fitbit web service |
| galileo | synchronize Fitbit trackers with Fitbit web service |
| galileo | synchronize Fitbit trackers with Fitbit web service |
| galileo | synchronize Fitbit trackers with Fitbit web service |

## Reference documentation
- [Galileo 2 Project Overview and Klipper Settings](./references/github_com_JaredC01_Galileo2.md)
- [Klipper Settings for G2 Extruders and G2 Z Drivers](./references/github_com_JaredC01_Galileo2_tree_main_galileo2_extruder.md)