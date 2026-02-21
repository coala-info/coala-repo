---
name: lua
description: This skill provides technical patterns and configuration workflows for Luanti (formerly Minetest), an open-source voxel game engine.
homepage: https://github.com/luanti-org/luanti
---

# lua

## Overview
This skill provides technical patterns and configuration workflows for Luanti (formerly Minetest), an open-source voxel game engine. While the engine is built in C++, its extensibility relies on a dedicated Lua API. This skill focuses on engine-specific CLI usage, directory structures across platforms, and critical security best practices for the Luanti Lua environment.

## Engine Configuration and CLI
Luanti uses a central configuration file and specific command-line arguments to manage engine behavior.

### Command Line Usage
*   **Custom Configuration**: Use `--config <path-to-file>` to load a specific `minetest.conf` file instead of the default.
*   **Help**: Access the full list of engine flags using `--help`.

### Platform-Specific Data Paths
When managing mods or worlds, locate the `user` directory based on the operating system:
*   **Windows**: `%APPDATA%\Minetest` or the local folder in "run-in-place" builds.
*   **Linux**: `~/.minetest`.
*   **macOS**: `~/Library/Application Support/minetest`.
*   **Worlds**: Always stored in `user/worlds/`.

## Lua Scripting Best Practices
Luanti's Lua environment has specific performance and security considerations.

### Security and Sandboxing
*   **Avoid `minetest.deserialize`**: Do not use this function on untrusted data or strings from players, as it is susceptible to Remote Code Execution (RCE) vulnerabilities.
*   **Sandbox Escapes**: Be aware that writable mod directories and insecure environment access can lead to sandbox escapes. Always restrict mod permissions to the minimum required.
*   **HTTP API**: Access to the HTTP API is restricted; ensure mods are explicitly allowed in `secure.http_mods` within `minetest.conf`.

### Performance Optimization
*   **Table Operations**: In version 5.15.1+, `table.copy` is optimized to avoid unnecessary closures.
*   **Vector Math**: Prefer the native `vector2` and `matrix` APIs (where available in recent versions) over manual table-based math for 2D and 3D transformations.
*   **Mapgen**: Eliminate redundant calculations in custom map generators to prevent server-side lag during chunk emergence.

## Reference documentation
- [Luanti Main Repository](./references/github_com_luanti-org_luanti.md)
- [Security Advisories](./references/github_com_luanti-org_luanti_security.md)
- [Documentation Directory Overview](./references/github_com_luanti-org_luanti_tree_master_doc.md)