---
name: mrs
description: The MRS UAV System is a specialized robotics framework developed by the Multi-robot Systems Group at CTU in Prague.
homepage: https://github.com/ctu-mrs/mrs_uav_system
---

# mrs

## Overview

The MRS UAV System is a specialized robotics framework developed by the Multi-robot Systems Group at CTU in Prague. It provides a robust pipeline for control, state estimation, mapping, and planning specifically for multi-rotor helicopters. This skill enables the management of the MRS environment, allowing for the transition between high-fidelity Gazebo simulations and real-world experimental validation. Use this skill to handle system installation, workspace configuration, and the boilerplate tasks required to develop new UAV behaviors within the MRS ecosystem.

## Installation and Environment Setup

The MRS system is primarily built for ROS Noetic on Ubuntu.

### 1. Add Repositories and Install
To install the full MRS system natively, use the stable PPA:

```bash
# Add ROS Noetic PPA
curl https://ctu-mrs.github.io/ppa-stable/add_ros_ppa.sh | bash
sudo apt install ros-noetic-desktop-full

# Add MRS Stable PPA
curl https://ctu-mrs.github.io/ppa-stable/add_ppa.sh | bash

# Install the full system
sudo apt install ros-noetic-mrs-uav-system-full
```

### 2. Initialize Catkin Workspace
The MRS system relies on specific catkin profiles for optimal performance.

```bash
source /opt/ros/noetic/setup.bash
mkdir -p ~/workspace/src && cd ~/workspace
catkin init -w ~/workspace

# Configure Release with Debug Info (Recommended for development)
catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17'
catkin profile set reldeb
```

## Simulation and Testing

The MRS system uses `tmux` to manage multiple ROS nodes and Gazebo simulation components simultaneously.

### Launching a Basic Simulation
To start a pre-configured simulation session with a single drone:

```bash
roscd mrs_uav_gazebo_simulation/tmux/one_drone
./start.sh
```

### Common Simulation Tasks
- **State Estimation**: The system supports various estimators (e.g., `mrs_point_lio`). Ensure the `EstimationManager` is active before attempting takeoff.
- **Takeoff**: Most MRS simulation sessions include a `tmux` pane for the "Control Visualizer" or a terminal where you can trigger automatic takeoff services.

## Developing New Packages

The most efficient way to create a new MRS-compatible package is to repurpose an existing example.

### Repurposing an Example
1. Clone the examples repository:
   `git clone https://github.com/ctu-mrs/mrs_core_examples.git ~/git/mrs_core_examples`
2. Copy a template (e.g., `waypoint_flier`):
   `cp -r ~/git/mrs_core_examples/cpp/waypoint_flier ~/git/my_new_package`
3. Run the repurposing script:
   ```bash
   cd ~/git/my_new_package
   cp ~/git/mrs_core_examples/repurpose_package.sh .
   ./repurpose_package.sh example_waypoint_flier my_new_package --camel-case
   ```
4. Link and build:
   ```bash
   ln -s ~/git/my_new_package ~/workspace/src
   cd ~/workspace && catkin build my_new_package
   ```

## Expert Tips
- **Unstable PPA**: For the latest features (at the risk of bugs), use `add_ppa.sh` from the `ppa-unstable` path instead of `ppa-stable`.
- **Shell Integration**: Always add `source ~/workspace/devel/setup.bash` to your `~.bashrc` to ensure your custom packages are visible to `roscd` and `roslaunch`.
- **Apptainer/Docker**: If native installation is not possible, the MRS system provides Apptainer (formerly Singularity) and Docker containers to maintain environment consistency.

## Reference documentation
- [MRS UAV System Main Repository](./references/github_com_ctu-mrs_mrs_uav_system.md)
- [MRS Community Discussions](./references/github_com_orgs_ctu-mrs_discussions.md)