---
name: pwiz
description: ProteoWizard is a modular toolset and library designed to convert and process mass spectrometry data across diverse vendor formats. Use when user asks to convert raw mass spectrometry files to mzML, perform peak picking or centroiding, and build the pwiz library from source.
homepage: https://github.com/ProteoWizard/pwiz
---


# pwiz

## Overview
ProteoWizard (pwiz) is a modular, open-source C++ library and toolset designed to simplify mass spectrometry data analysis. Its primary function is to provide a unified interface for accessing diverse data formats, effectively acting as a "universal translator" for proteomics. The most widely used component is `msconvert`, a command-line tool for high-throughput data conversion and filtering.

## Command-Line Usage and Best Practices

### Building the Library
ProteoWizard uses a custom build system based on Boost.Build. Avoid using ad-hoc compiler calls.
- **Windows**: Run `quickbuild.bat` from a Developer Command Prompt.
- **Linux/macOS**: Run `./quickbuild.sh`.
- **Clean Build**: Use `clean.bat` or `clean.sh` to remove previous build artifacts before a fresh attempt.

### Primary Tool: msconvert
`msconvert` is the standard utility for converting vendor files to mzML.
- **Basic Conversion**: `msconvert data_file.raw`
- **Vendor Support**: Direct reading of vendor formats (Thermo .raw, Sciex .wiff, etc.) is primarily supported on **Windows** due to proprietary DLL dependencies.
- **Linux Usage**: For vendor formats on Linux, ProteoWizard is often run via **Wine**. Native Linux support is generally limited to open formats unless specific vendor-provided libraries are available.

### Common Workflow Patterns
- **Centroiding**: When converting profile data to centroided data (essential for many search engines), use the peak picking filter.
- **Filtering**: You can subset data by scan number, acquisition time, or MS level during the conversion process to reduce file size.
- **Output Formats**: While mzML is the default and recommended format, the tool also supports mzXML, MGF, and MS2.

### Development Guidelines
- **C++ Development**: Core libraries are located in `pwiz/`, `pwiz_tools/`, and `pwiz_aux/`.
- **Skyline Integration**: If working on the Skyline proteomics environment, it is located under `pwiz_tools/Skyline`. Always work from a full checkout of the `pwiz` repository rather than the Skyline subtree alone.
- **Threading**: The project avoids `async/await` in favor of deterministic threading. Use `CommonActionUtil.RunAsync()` or `ActionUtil.RunAsync()` for background tasks.
- **Coding Style**: C# code follows specific conventions enforced by the repository-wide `.editorconfig`.

## Expert Tips
- **Path Lengths**: When working on Windows, ensure long path support is enabled, especially when building or using complex library structures.
- **Vendor Licenses**: When building from source to include vendor support, you must explicitly agree to vendor licenses (e.g., using the `--i-agree-to-the-vendor-licenses` flag in build scripts).
- **Binary Location**: After a successful build on Windows, the resulting executables are typically found in `build-nt-x86/msvc-release-x86_64/`.

## Reference documentation
- [ProteoWizard README](./references/github_com_ProteoWizard_pwiz.md)
- [ProteoWizard Commits](./references/github_com_ProteoWizard_pwiz_commits_master.md)