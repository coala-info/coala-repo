---
name: libcarna
description: LibCarna is a specialized C++ library based on OpenGL 3.3 and Eigen 3, designed for high-performance 3D visualization of medical datasets.
homepage: https://github.com/kostrykin/Carna
---

# libcarna

## Overview
LibCarna is a specialized C++ library based on OpenGL 3.3 and Eigen 3, designed for high-performance 3D visualization of medical datasets. It is particularly effective for rendering volumetric data and generating synthetic radiographs. This skill provides the necessary procedures for environment setup, compilation with or without EGL support, and CMake integration.

## Installation and Setup

### Quick Install (Linux 64-bit)
The fastest way to deploy the library is via Bioconda:
```bash
conda install bioconda::libcarna
```

### Build Requirements
Ensure the following dependencies are present before building from source:
- **Core**: OpenGL ≥ 3.3, Eigen ≥ 3.0.5, CMake ≥ 3.28.
- **Extended (Demo/Tests)**: Boost.Iostreams, Qt ≥ 4 (tested up to 5.15).

## Build Patterns

### Standard Desktop Build
Use this for development and running the included demo application. This build uses standard windowing systems (via Qt).
```bash
./linux_build-default.bash
```

### Headless / Offscreen Rendering (EGL)
Use this for server-side rendering or automated image generation where no X-server is available. Note that this disables the Qt-based demo and test suite.
```bash
./linux_build-egl.bash
```

## Project Integration

To include LibCarna in a C++ project, use the standard CMake `find_package` workflow. 

### CMake Configuration
Add the following to your `CMakeLists.txt`:
```cmake
find_package(LibCarna REQUIRED)

add_executable(my_medical_app main.cpp)
target_link_libraries(my_medical_app Private LibCarna::LibCarna)
```

### Expert Tips
- **EGL Conflict**: Do not attempt to initialize Qt-based components if the library was compiled with EGL support, as they are mutually exclusive in the provided build scripts.
- **Data Handling**: Since the library relies on Eigen 3, ensure your data structures for coordinates and transformations are aligned with Eigen's memory requirements to avoid performance bottlenecks during real-time rendering.
- **Python Bindings**: If working in a data science context, refer to `LibCarna-Python` for high-level bindings that interface with these C++ primitives.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_kostrykin_LibCarna.md)
- [Anaconda Package Details](./references/anaconda_org_channels_bioconda_packages_libcarna_overview.md)