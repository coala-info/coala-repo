---
name: julia
description: Julia is a high-level, high-performance dynamic language designed for technical and scientific computing. Use when user asks to install or build Julia from source, manage environments and packages, or execute scripts and numerical simulations via the CLI.
homepage: https://github.com/JuliaLang/julia
metadata:
  docker_image: "quay.io/biocontainers/julia:1.10"
---

# julia

## Overview

Julia is a high-level, high-performance dynamic language specifically designed for technical and scientific computing. This skill enables users to effectively manage Julia installations, build the language from its source repository, and navigate the command-line interface (CLI). It is particularly useful for developers needing to set up reproducible environments, contribute to the Julia core, or execute numerical simulations and data analysis tasks.

## Installation and Version Management

The recommended way to manage Julia is through the official version multiplexer rather than system package managers, which are often outdated.

- **Recommended Setup**: Use `juliaup` to install the latest stable version and manage multiple versions simultaneously.
- **Manual Binaries**: Download specific platform binaries from the official downloads page for Tier 1 support (Linux, macOS, Windows).
- **Environment**: Ensure `~/.julia` is available, as this is where packages, compiled caches, and logs are stored.

## Building from Source

Building Julia is necessary for core development or when specific build-time optimizations are required.

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/JuliaLang/julia.git
   cd julia
   ```
2. **Select a Version**:
   ```bash
   git checkout v1.12.2  # Replace with the desired stable tag
   ```
3. **Compile**:
   Run `make` in the root directory.
   - **Requirements**: Minimum 2GiB disk space and 4GiB virtual memory.
   - **Constraint**: Ensure the parent directory path contains no spaces or shell meta-characters (e.g., `$`, `:`), as this breaks the GNU make process.
4. **Verification**:
   After a successful build, run the local executable:
   ```bash
   ./julia
   ```
   To run the full test suite:
   ```bash
   make testall
   ```

## CLI Usage and REPL Patterns

Julia provides a powerful interactive Read-Eval-Print Loop (REPL) and a flexible CLI for script execution.

- **Execute a Script**: `julia script.jl`
- **Run with Multiple Threads**: `julia -t <n>` or set the `JULIA_NUM_THREADS` environment variable.
- **Load a Project/Environment**: `julia --project=@.` (activates the Project.toml in the current directory).
- **REPL Modes**:
  - **Julian mode**: The default prompt `julia>`.
  - **Pkg mode**: Press `]` to manage packages (e.g., `add DataFrames`).
  - **Shell mode**: Press `;` to execute system commands.
  - **Help mode**: Press `?` to access documentation for functions and types.

## Source Organization for Developers

When navigating the Julia source tree, use the following directory map:
- `base/`: Core language functionality (the `Base` module).
- `stdlib/`: Standard library packages (e.g., LinearAlgebra, Statistics).
- `src/`: C/C++ source for the Julia core and runtime.
- `test/`: Unit tests for the language and libraries.
- `contrib/`: Useful scripts for developers (e.g., `juliac.jl` for compilation).

## Reference documentation
- [The Julia Programming Language](./references/github_com_JuliaLang_julia.md)
- [Julia Source Documentation](./references/github_com_JuliaLang_julia_tree_master_doc.md)