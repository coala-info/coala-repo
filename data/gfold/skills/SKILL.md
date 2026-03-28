---
name: gfold
description: "gfold provides a read-only overview of local Git repositories to track their status, branches, and uncommitted changes. Use when user asks to scan directories for Git repository statuses, identify uncommitted changes across multiple projects, or display a summary of local Git ecosystems in various formats."
homepage: https://github.com/nickgerace/gfold
---

# gfold

## Overview

`gfold` is a high-performance, concurrent Git repository tracking tool written in Rust. It provides a read-only overview of your local Git ecosystem, allowing you to quickly identify which repositories have uncommitted changes, are ahead/behind their remotes, or are on specific branches. It is particularly useful for developers managing large "src" or "projects" directories containing dozens of repositories.

## Core Usage Patterns

### Basic Discovery
By default, `gfold` crawls the current working directory recursively to find and display Git repositories.

```bash
# Scan current directory
gfold

# Scan specific directories (supports multiple paths)
gfold ~/src ~/work/projects
```

### Display Modes
The tool supports different output formats to suit your terminal size or information density needs.

- **Standard (Default)**: A modern, color-coded layout.
- **Classic**: A more traditional, condensed view.
- **Json**: Useful for piping data into other tools or scripts.

```bash
# Use classic display mode
gfold -d classic

# Output as JSON for programmatic use
gfold -d json
```

### Configuration and Automation
`gfold` looks for an optional config file at `$HOME/.config/gfold.toml`. You can generate a template using the `--dry-run` flag.

```bash
# Generate a TOML config based on current flags
gfold -d classic -c never ~/src --dry-run > $HOME/.config/gfold.toml

# Ignore existing config for a one-off command
gfold -i
```

## Expert Tips

- **Concurrency**: `gfold` uses the `rayon` library to perform analysis in parallel. It is safe to run on very large directory trees.
- **Read-Only**: The tool never writes to the filesystem or your `.git` folders, making it safe for use in automated monitoring scripts.
- **Worktree Support**: Recent versions (2025.7.0+) include support for Git worktrees, displaying them alongside standard repositories.
- **Color Control**: Use `-c` or `--color` (always, never, auto) to manage ANSI color output, which is helpful when redirecting output to log files.
- **Manual Generation**: Use the `--generate-man` flag to create a man page for offline reference.



## Subcommands

| Command | Description |
|---------|-------------|
| gfold_count | Generalized fold change for ranking differentially expressed genes from RNA-seq data. |
| gfold_diff | Generalized fold change for ranking differentially expressed genes from RNA-seq data. |

## Reference documentation
- [gfold README](./references/github_com_nickgerace_gfold_blob_main_README.md)
- [Changelog](./references/github_com_nickgerace_gfold_blob_main_CHANGELOG.md)
- [Cargo Configuration](./references/github_com_nickgerace_gfold_blob_main_Cargo.toml.md)