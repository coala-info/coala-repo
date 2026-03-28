---
name: mrs
description: The MRS UAV System provides a ROS-based ecosystem for developing, simulating, and deploying autonomous multi-rotor helicopter software. Use when user asks to install the MRS environment, initialize catkin workspaces with specific build profiles, or manage multi-drone Gazebo simulation sessions.
homepage: https://github.com/ctu-mrs/mrs_uav_system
---


# mrs

## Overview

The MRS UAV System is a specialized ROS-based ecosystem designed for the development and testing of autonomous multi-rotor helicopters. It bridges the gap between high-fidelity simulations and real-world deployment by providing standardized pipelines for control, state estimation, and multi-robot coordination. This skill assists in setting up the environment, managing build profiles, and executing simulation sessions.

## Installation and Setup

### Repository Configuration
To install the system on a native Ubuntu (Noetic) environment, first add the stable PPA:

```bash
curl https://ctu-mrs.github.io/ppa-stable/add_ppa.sh | bash
sudo apt update
sudo apt install ros-noetic-mrs-uav-system-full
```

For developers requiring the latest features, the unstable PPA can be used, though it may be inconsistent:
`curl https://ctu-mrs.github.io/ppa-unstable/add_ppa.sh | bash`

### Workspace Initialization
The MRS system requires specific compiler flags and build profiles for optimal performance. Use the following pattern to initialize a catkin workspace:

```bash
source /opt/ros/noetic/setup.bash
mkdir -p ~/mrs_workspace/src && cd ~/mrs_workspace
catkin init

# Configure build profiles (Debug, Release, RelWithDebInfo)
catkin config --profile debug --cmake-args -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS='-std=c++17 -Og'
catkin config --profile release --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS='-std=c++17'
catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_FLAGS='-std=c++17'

# Set active profile
catkin profile set reldeb
```

## Simulation Management

### Starting Gazebo Sessions
MRS simulations typically rely on `tmux` to manage multiple ROS nodes and drone instances simultaneously.

1. Navigate to the simulation directory:
   `roscd mrs_uav_gazebo_simulation/tmux/one_drone`
2. Execute the startup script:
   `./start.sh`

### Common CLI Operations
- **roscd**: Use this to quickly jump to MRS package directories (e.g., `roscd mrs_uav_manager`).
- **tmuxinator**: Many MRS examples use tmuxinator configs. If a session fails to start, check the `session.yml` in the local directory.

## Expert Tips and Best Practices

### Altitude and Positioning
- **RTK Altitude**: When using RTK state estimators, the system defaults to the WGS84 ellipsoid model. Note that this may differ from Geoid models (EGM96/2008) used by standard Pixhawk GNSS by tens of meters.
- **TF Frames**: Ensure the `fcu -> rtk_antenna` transform is provided in your tmux session if using RTK, as it is drone-specific and no longer published by default launch files.

### Hardware API
The system is simulator-agnostic. If switching from Gazebo to a different simulator (like FlightForge or CoppeliaSim), you must provide the appropriate `mrs_uav_hw_api` plugin implementation.

### Versioning
- **ROS1 (Noetic)**: Use the `master` branch and documentation version 1.5.0.
- **ROS2**: Use the `ros2` branch and documentation version 2.0.0. API calls and package names differ significantly between these versions.



## Subcommands

| Command | Description |
|---------|-------------|
| mrs build | Build a databank |
| mrs dump | Dump mrs data |
| mrs validate | Validate MRS data |
| mrs_blast | Perform BLAST search |
| mrs_entry | Display entry information |
| mrs_fetch | Fetch data from a databank. |
| mrs_info | Display information about mrs tool |
| mrs_password | Modify user password information |
| mrs_query | Query the MRS databank |
| mrs_server | (No description) |
| mrs_update | Update the mrs databank. |
| mrs_vacuum | mrs vacuum |

## Reference documentation
- [MRS UAV System README](./references/github_com_ctu-mrs_mrs_uav_system_blob_master_README.md)
- [Installation Guide](./references/ctu-mrs_github_io_docs_installation.md)
- [MRS API Overview](./references/ctu-mrs_github_io_docs_api.md)
- [Simulation Documentation](./references/ctu-mrs_github_io_docs_simulations.md)