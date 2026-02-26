---
name: pp
description: The pp skill provides procedural knowledge for building, testing, and debugging the PPSSPP emulator codebase. Use when user asks to build the headless target, run automated test suites, or perform graphics analysis using display list dumps.
homepage: https://github.com/hrydgard/ppsspp
---


# pp

## Overview
The `pp` skill provides procedural knowledge for working with the PPSSPP (PSP emulator) codebase and its associated command-line utilities. While PPSSPP is widely known for its graphical user interface, this skill focuses on the "Headless" and "Unit Test" components used for automated testing, performance benchmarking, and deep debugging. Use this skill to navigate the build system, execute the test suite, and utilize specialized debugging procedures like display list dumping to identify rendering regressions.

## Build and Environment Setup
PPSSPP uses a CMake-based build system with helper scripts for various platforms.

- **Standard Build**: Use the provided shell scripts for quick compilation.
  - `./b.sh`: The primary build script for Linux/macOS.
  - `./b-ios.sh`: Specialized script for iOS builds.
- **Dependencies**: Ensure submodules are initialized, as PPSSPP relies on external libraries (ffmpeg, ext/) and test data (pspautotests).
- **Headless Target**: When debugging or testing, prioritize building the `PPSSPPHeadless` target, which removes the requirement for a display server.

## Testing and Validation
The repository contains a robust suite of automated tests to ensure emulation accuracy.

- **Unit Tests**: Run the `unittest` executable generated during the build process to verify Core components.
- **Integration Tests**: Use the `test.py` script located in the root directory to run the full suite of PSP autotests.
  - Pattern: `python3 test.py ./PPSSPPHeadless`
- **JIT Debugging**: If you suspect a Just-In-Time (JIT) compiler bug, use the "easy way" mentioned in the wiki: compare the output of the JIT core against the Interpreter core to find the first point of divergence.

## Debugging and Graphics Analysis
When a game exhibits graphical glitches or crashes, use these specialized workflows:

- **Display List Dumps**: Create a `.ppdmp` file to capture the exact commands sent to the GPU. This is essential for reporting rendering bugs that are difficult to reproduce.
- **Frame Dumps**: Use the GE (Graphics Engine) debugger to step through draw calls.
- **Android Debugging**: For crashes on Android, use `addr2line` combined with the `adb logcat` output to map memory addresses back to the C++ source code.
- **Vulkan Validation**: If using the Vulkan backend, enable Vulkan validation layers via the settings or environment variables to catch API misuse.

## Expert Tips
- **HLE vs LLE**: PPSSPP is a High-Level Emulation (HLE) emulator by default. If a game fails, check if specific modules (like `scePsmf` or `sceAtrac`) can be switched to Low-Level Emulation (LLE) if the original modules are provided.
- **MIPS Hooks**: For advanced modding or debugging, utilize the `MIPSHooks` in the Interpreter core to intercept function calls.
- **Texture Replacement**: Use the `textures.ini` syntax to identify and replace in-game assets for HD texture packs.

## Reference documentation
- [PPSSPP README](./references/github_com_hrydgard_ppsspp.md)
- [PPSSPP Wiki Home](./references/github_com_hrydgard_ppsspp_wiki.md)
- [Build Scripts and Structure](./references/github_com_hrydgard_ppsspp_commits_master.md)