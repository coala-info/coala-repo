---
name: bx-tools
description: The bx-tools (elf-bf-tools) suite is a specialized collection of utilities designed to exploit the "weird machine" capabilities of the GCC runtime loader.
homepage: https://github.com/bx/elf-bf-tools
---

# bx-tools

## Overview
The bx-tools (elf-bf-tools) suite is a specialized collection of utilities designed to exploit the "weird machine" capabilities of the GCC runtime loader. By leveraging valid ELF relocation entries and symbols, these tools can coerce the dynamic linker into performing complex operations, including Turing-complete computation, without executing traditional machine code. This skill provides the procedural knowledge required to build the environment, compile relocation-based logic, and debug the dynamic loading process.

## Environment and Dependencies
The toolset is highly sensitive to the environment due to its reliance on specific `ld.so` behaviors.
- **Target OS**: Ubuntu 11.10 x86_64 (Oneiric). If using a modern system, a 64-bit Oneiric chroot is required.
- **Core Dependency**: Eresi (The ERESI Reverse Engineering Software Interface).
- **System Requirements**: amd64 architecture with eglibc 2.13.

### Building Eresi
Before building bx-tools, Eresi must be installed from source:
1. Checkout: `svn checkout http://svn.eresi-project.org/svn/trunk/ eresi`
2. Configure: `./configure --prefix /usr/local --enable-64`
3. Build: `make`
4. Install: `sudo make install install64` (Ignore chmod errors on dangling symlinks for `libelfsh.so`).

## Toolset Components and Usage

### Building bx-tools
Use CMake to build the entire suite:
```bash
cmake .
make
```

### Brainfuck to ELF Compiler (`elf_bf_compiler`)
This tool compiles Brainfuck source code into an ELF binary where the logic is executed entirely by the dynamic linker during relocation.
- **Best Practice**: Use this for creating binaries that perform computation during the loading phase, effectively hiding logic from standard entry-point analysis.
- **Capabilities**: Supports `putchar` and `getchar` via relocation side effects.

### Debugging the Loader (`elf_bf_debug`)
The runtime loading process is opaque. Use the scripts in this directory to trace how relocation entries are processed.
- **Usage**: Essential when your relocation-based logic fails to trigger the expected state changes in the dynamic linker.

### Relocation Backdoors (`ping_backdoor`)
This serves as a reference implementation for injecting logic into existing system utilities.
- **Mechanism**: It uses relocation entries to build a functional backdoor into the `ping` utility.
- **Expert Tip**: Study this code to understand how to redirect control flow or modify data structures using only valid ELF metadata.

## Expert Tips
- **Relocation Types**: Focus on how different relocation types (e.g., `R_X86_64_GLOB_DAT`, `R_X86_64_JUMP_SLOT`) can be abused to write values to arbitrary memory locations.
- **Symbol Shadowing**: Use symbol definitions to provide the "data" that relocations will act upon.
- **Library Loading**: Remember that the logic executes when the library or binary is first loaded by `ld.so`. If the environment's linker differs from eglibc 2.13, the relocation side effects may vary or fail.

## Reference documentation
- [Main README](./references/github_com_bx_elf-bf-tools.md)