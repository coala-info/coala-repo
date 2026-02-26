---
name: xdg
description: xdg helps applications find standard filesystem paths for user-specific configuration, data, and cache files. Use when user asks to get the configuration directory, find the data directory, locate the cache directory, determine the state directory, or retrieve the runtime directory.
homepage: https://github.com/srstevenson/xdg
---


# xdg

## Overview
The `xdg-base-dirs` module (formerly known as `xdg`) provides a reliable way to determine the correct filesystem paths for application-specific files. By using this tool instead of hardcoding hidden directories in the user's home folder, you ensure that your application respects system environment variables like `XDG_CONFIG_HOME` and `XDG_CACHE_HOME`. The library returns `pathlib.Path` objects, making it easy to perform cross-platform filesystem operations.

## Installation and Setup
Install the package using one of the following methods:
- **uv**: `uv add xdg-base-dirs`
- **pip**: `pip install xdg-base-dirs`
- **Conda**: `conda install bioconda::xdg`

Note: If migrating from the older `xdg` package, update the dependency name to `xdg-base-dirs` and change imports from `import xdg` to `from xdg_base_dirs import ...`.

## Core Functions
Import the specific functions needed for your application's storage requirements:

- `xdg_config_home()`: Returns the path for user-specific configuration files (Default: `~/.config`).
- `xdg_data_home()`: Returns the path for user-specific data files (Default: `~/.local/share`).
- `xdg_cache_home()`: Returns the path for non-essential user-specific data files (Default: `~/.cache`).
- `xdg_state_home()`: Returns the path for user-specific state data like logs, history, or current sessions (Default: `~/.local/state`).
- `xdg_runtime_dir()`: Returns a path for runtime files and communication objects. Returns `None` if the system has not initialized the environment variable.

## Best Practices
- **Initialize Directories**: Always call `.mkdir(parents=True, exist_ok=True)` on the returned path before attempting to write files, as the XDG directories or your application's subdirectory may not exist yet.
- **Use Subdirectories**: Append your application name to the base path to avoid cluttering the root XDG directories (e.g., `xdg_config_home() / "my-app" / "config.toml"`).
- **Handle Search Paths**: When looking for system-wide configurations or data, use `xdg_config_dirs()` and `xdg_data_dirs()`. These return a list of paths to check in order of preference.
- **Path Validation**: The library automatically ignores relative paths found in environment variables and falls back to specification defaults. Do not manually validate if a path is absolute; the library handles this.
- **Pathlib Integration**: Since the functions return `pathlib.Path` objects, leverage methods like `.read_text()`, `.write_text()`, and `/` operator joining for cleaner code.

## Reference documentation
- [xdg-base-dirs GitHub README](./references/github_com_srstevenson_xdg-base-dirs.md)
- [Bioconda xdg Package Overview](./references/anaconda_org_channels_bioconda_packages_xdg_overview.md)