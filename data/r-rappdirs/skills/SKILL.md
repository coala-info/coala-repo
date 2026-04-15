---
name: r-rappdirs
description: This tool determines standard, platform-specific system directories for saving application data, caches, and logs in R. Use when user asks to find cross-platform storage paths, determine where to save R package configuration files, or locate standard directories for application logs and caches.
homepage: https://cloud.r-project.org/web/packages/rappdirs/index.html
---

# r-rappdirs

name: r-rappdirs
description: Determine standard system directories for saving application data, caches, and logs in R. Use this skill when you need to ensure an R package or script follows platform-specific conventions (Windows, macOS, Linux) for persistent storage, avoiding hardcoded paths and ensuring files are placed in locations users expect.

# r-rappdirs

## Overview

The `rappdirs` package is an R port of Python's `appdirs` module. It provides a consistent, cross-platform API for determining where an application should store data, configuration files, caches, and logs. This ensures that R applications behave like native applications on every operating system.

## Installation

```R
install.packages("rappdirs")
```

## Core Functions

The package provides functions for different types of application storage. Most functions take `appname`, `appauthor` (required for Windows), and an optional `version`.

### User-Specific Directories (Recommended)

These are the most common functions for storing user-specific application state.

*   **Data**: `user_data_dir(appname, appauthor)`
    *   macOS: `~/Library/Application Support/<appname>`
    *   Win 7+: `C:\Users\<user>\AppData\Local\<appauthor>\<appname>`
    *   Linux: `~/.local/share/<appname>`
*   **Config**: `user_config_dir(appname, appauthor)`
    *   Same as data on Windows/macOS.
    *   Linux: `~/.config/<appname>`
*   **Cache**: `user_cache_dir(appname, appauthor)`
    *   Used for non-essential data that can be regenerated.
    *   Linux: `~/.cache/<appname>`
*   **Logs**: `user_log_dir(appname, appauthor)`
    *   macOS: `~/Library/Logs/<appname>`
    *   Windows: Appends `\Logs` to the data directory.

### System-Wide Directories

Use these for shared data accessible by all users on the machine.

*   **Site Data**: `site_data_dir(appname, appauthor)`
*   **Site Config**: `site_config_dir(appname, appauthor)`

## Common Workflows

### Initializing a Data Path

When starting a project that needs to save a local database or RDS file:

```R
library(rappdirs)

# Define the path
db_path <- user_data_dir("my_r_tool", "my_org")

# Ensure the directory exists before writing
if (!dir.exists(db_path)) {
  dir.create(db_path, recursive = TRUE)
}

# Save data
saveRDS(my_data, file.path(db_path, "data.rds"))
```

### Handling Versions

If you need to support multiple versions of an app simultaneously without data collision:

```R
# Returns path ending in .../my_app/1.0
v1_path <- user_data_dir("my_app", version = "1.0")
```

### Windows Roaming Profiles

For Windows environments where users move between machines, use `roaming = TRUE` in `user_data_dir()` or `user_config_dir()` to ensure data follows the user.

```R
# Uses AppData\Roaming instead of AppData\Local
config_path <- user_config_dir("my_app", "my_org", roaming = TRUE)
```

## Tips and Best Practices

1.  **Always provide appauthor**: While optional on Unix/macOS, `appauthor` is a standard part of the path on Windows. Providing it ensures consistent behavior across all platforms.
2.  **Check for existence**: `rappdirs` only returns the *string path*. It does not create the directory. Always use `dir.create(path, recursive = TRUE)` before attempting to write files.
3.  **Use user_cache_dir for speed**: If your app downloads large datasets or performs heavy computations, store results in the cache directory so they can be cleared by system utilities if disk space is low.
4.  **Testing OS behavior**: You can preview what a path would look like on a different OS by passing the `os` argument (e.g., `os = "win"`, `os = "mac"`, or `os = "unix"`).

## Reference documentation

- [rappdirs: Application Directories: Determine Where to Save Data, Caches, and Logs](./references/reference_manual.md)