---
name: gfold
description: "gfold is a CLI tool that provides a concurrent, read-only status overview of multiple Git repositories. Use when user asks to scan directories for Git repository health, check for uncommitted changes across projects, or output repository status in JSON or classic formats."
homepage: https://github.com/nickgerace/gfold
---


# gfold

## Overview
gfold is a high-performance CLI tool written in Rust that provides a bird's-eye view of your Git repositories. It leverages concurrent processing to scan directories and report on the health and status of every repository it finds. Because it is strictly read-only, it is safe to use in any environment to quickly identify which projects have uncommitted changes or need to be pushed/pulled.

## Usage Patterns

### Basic Repository Tracking
Scan the current directory and all subdirectories for Git repositories:
```bash
gfold
```

Scan specific paths or multiple locations at once:
```bash
gfold ~/src ~/projects/work
```

### Display and Output Control
If you prefer a more condensed output or need to process the data programmatically:
- **Classic Display**: Use `-d classic` for a traditional list view.
- **JSON Output**: Use `-d json` for machine-readable data.
- **Color Control**: Use `-c always`, `-c never`, or `-c auto` to manage terminal color output.

### Configuration Management
gfold uses a TOML configuration file located at `~/.config/gfold.toml` or `$XDG_CONFIG_HOME/gfold.toml`. 

To generate a configuration based on your current CLI flags, use the dry-run flag:
```bash
gfold -d classic -c auto ~/src --dry-run > ~/.config/gfold.toml
```

To bypass your configuration file and use default settings:
```bash
gfold -i
```

## Expert Tips

### Troubleshooting and Verbosity
If a repository isn't appearing or you suspect an error during traversal, increase the verbosity to see the underlying `git2-rs` analysis:
```bash
gfold -vvv
```

### macOS Naming Collision
On macOS, if you have GNU `coreutils` installed, the `fold` command is often aliased to `gfold`. To avoid this conflict, you can:
1. Use the full path to the Rust binary (usually `~/.cargo/bin/gfold`).
2. Create a specific alias in your shell profile: `alias gfld='$(which gfold)'`.

### Performance
gfold uses the `rayon` library for concurrent analysis. It is significantly faster than shell scripts or loops that execute `git status` sequentially. Use it at the root of your "workspace" or "src" folders to get an instant status report across dozens of repositories.

## Reference documentation
- [nickgerace/gfold](./references/github_com_nickgerace_gfold.md)