---
name: stride
description: Stride is a high-performance C# game engine used for realistic rendering, VR applications, and procedural engine development. Use when user asks to clone the repository with Git LFS, restore dependencies, build the engine or Game Studio via command line, and troubleshoot environment issues.
homepage: https://github.com/stride3d/stride
metadata:
  docker_image: "quay.io/biocontainers/stride:1.0--1"
---

# stride

## Overview
Stride is a high-performance, modular C# game engine designed for realistic rendering and VR applications. This skill focuses on the procedural knowledge required to clone, restore, and build the engine and its primary editor, Game Studio, using command-line tools and the .NET ecosystem. It is intended for developers who need to move beyond the standard installer to customize the engine or contribute to its open-source repository.

## Environment Setup
Before executing build commands, ensure the host environment meets these specific requirements:
- **SDK**: .NET 10.0 SDK or later.
- **Git**: Must have Git Large File Support (LFS) enabled.
- **Visual Studio Workloads**: Requires "Desktop development with C++" with specific components:
    - Windows 11 SDK (10.0.22621.0+)
    - MSVC v143 (x64/x86 and ARM64/ARM64EC)
    - C++/CLI support for v143 build tools

## Common CLI Patterns

### Repository Initialization
Always use Git LFS for cloning. Standard ZIP downloads or clones without LFS will result in broken asset files.
```bash
git lfs clone https://github.com/stride3d/stride.git
```

### Building via Command Line
If building without the Visual Studio IDE, use the following sequence from the `/build` directory:

1. **Restore Dependencies**:
   ```bash
   msbuild /t:Restore Stride.sln
   ```
2. **Execute Build Script**:
   ```bash
   compile.bat
   ```

### Maintenance and Troubleshooting
When builds fail due to environment corruption or stale caches, use these commands:

- **Clear NuGet Cache**:
  ```bash
  dotnet nuget locals all --clear
  ```
- **Clean Environment**:
  - Delete the hidden `.vs` folder in `\build`.
  - Delete all files inside `bin\packages`.
  - Kill any active `msbuild` processes before retrying.

## Expert Tips
- **MSBuild Path**: Ensure the correct version of MSBuild (associated with Visual Studio 2026/latest) is in your system PATH. Older versions (e.g., from VS 2019) will cause compatibility errors.
- **Platform Targets**: While the main solution is `Stride.sln`, platform-specific builds should use `Stride.Android.sln` or `Stride.iOS.sln` after the main editor components are built.
- **Test Failures**: It is common for some test projects to fail during a full solution build; this typically does not prevent `Stride.GameStudio` from launching successfully.
- **Interactive Mode**: When running graphics unit tests, Stride provides an option to suppress window pop-ups to prevent disruption of the user's desktop environment.

## Reference documentation
- [Welcome to Stride](./references/github_com_stride3d_stride.md)
- [Stride Discussions](./references/github_com_stride3d_stride_discussions.md)
- [Stride Issues](./references/github_com_stride3d_stride_issues.md)