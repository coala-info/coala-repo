---
name: raster3d
description: Raster3D is a CUDA-accelerated 3D rendering engine that implements core graphics pipeline features like perspective projection and flat shading. Use when user asks to set up the development environment, compile the engine using the Makefile, or navigate the live render view using interactive controls.
homepage: https://github.com/Sundance636/Raster3D
metadata:
  docker_image: "biocontainers/raster3d:v3.0-3-5-deb_cv1"
---

# raster3d

## Overview
Raster3D is a custom-built 3D rendering engine that leverages CUDA for GPU acceleration. It implements core graphics pipeline features including perspective projection, coordinate transformations, flat shading, and frustum culling. This skill should be used when you need to set up the development environment, compile the engine using the provided Makefile, or interact with the live render view.

## Environment Setup
The engine is designed for Linux and requires specific hardware and software dependencies:
- **Hardware**: NVIDIA GPU (CUDA-compatible).
- **Dependencies**: CUDA Toolkit and SDL2 libraries.
- **Installation (Arch Linux)**: `sudo pacman -S cuda sdl2`

## Build and Execution Patterns
The project uses a Makefile for build management. Navigate to the root directory to execute the following:

- **Standard Build**:
  ```bash
  make
  ```
- **Profile Build**: Compiles the project and runs it through `nvprof` to analyze GPU performance and runtime bottlenecks.
  ```bash
  make profile
  ```
- **Manual Execution**:
  ```bash
  ./Engine
  ```

## Interactive Controls
Once the engine is running, the camera starts at the origin (0,0,0). Use the following keyboard inputs to navigate the 3D space:

| Action | Key |
| :--- | :--- |
| **Pan Camera** | Arrow Keys |
| **Rotate Up/Down** | W / S |
| **Rotate Left/Right** | A / D |
| **Move Forward** | E |
| **Move Backward** | Q |

## Expert Tips
- **Terminal Monitoring**: The engine outputs continuous scene data to the terminal. Monitor this for real-time feedback on camera coordinates and scene state.
- **Performance Analysis**: Always use `make profile` when testing new shaders or high-poly models (like the "High Poly Cat" example) to ensure the CUDA kernels are executing efficiently.
- **Troubleshooting**: If the engine fails to launch, verify that your `LD_LIBRARY_PATH` includes the CUDA and SDL2 paths.

## Reference documentation
- [Raster3D Main Repository](./references/github_com_Sundance636_Raster3D.md)
- [Commit History and Features](./references/github_com_Sundance636_Raster3D_commits_main.md)