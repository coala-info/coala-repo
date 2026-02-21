---
name: fisher
description: Fisher is a lightweight, concurrent plugin manager for the Fish shell.
homepage: https://github.com/jorgebucaran/fisher
---

# fisher

## Overview
Fisher is a lightweight, concurrent plugin manager for the Fish shell. It is written in pure Fish script and designed to have zero impact on shell startup time. It enables users to modularize their shell configuration by installing external functions, completions, and themes, while maintaining a simple, flat dependency structure through a central configuration file.

## Core CLI Usage

### Installing Plugins
Plugins can be installed from GitHub (default), GitLab, or local directories.
- **GitHub**: `fisher install jorgebucaran/nvm.fish`
- **GitLab**: `fisher install gitlab.com/owner/repo`
- **Specific Version**: Append `@` followed by a tag, branch, or commit: `fisher install IlanCosman/tide@v6`
- **Local Directory**: `fisher install ~/path/to/plugin_folder`

### Managing Installed Plugins
- **List**: `fisher list` (supports regex filtering, e.g., `fisher list \^/` for local plugins).
- **Update**: `fisher update` (updates all plugins) or `fisher update jorgebucaran/fisher` (updates specific plugin).
- **Remove**: `fisher remove jorgebucaran/nvm.fish`.
- **Bulk Cleanup**: To remove everything including Fisher itself: `fisher list | fisher remove`.

## Expert Patterns and Best Practices

### Declarative Configuration with fish_plugins
Fisher tracks all installed plugins in `$__fish_config_dir/fish_plugins`. 
- **Dotfiles Integration**: Commit this file to your version control to synchronize your shell environment across machines.
- **Batch Editing**: You can manually edit the `fish_plugins` file (adding or removing lines) and then run `fisher update` to synchronize your installed state with the file content.

### Custom Installation Path
By default, Fisher expands plugins into your Fish configuration directory. To change this:
1. Set the `$fisher_path` variable in your `config.fish`.
2. Add the new path to your function, completion, and configuration paths.
3. Note: If using themes with a custom `$fisher_path`, you must symlink the themes directory: `ln -s $fisher_path/themes $__fish_config_dir/themes`.

### Plugin Development
A standard Fisher plugin follows this directory structure:
- `functions/`: Autoloaded functions.
- `conf.d/`: Configuration snippets executed at shell startup.
- `completions/`: Tab-completion scripts.
- `themes/`: `.theme` files for Fish 3.4+ compatibility.

### Using the Event System
Plugins can react to lifecycle events. These handlers must be placed in `conf.d/` to ensure they are loaded when the event triggers:
- `function _plugin_install --on-event plugin_install`: Runs on initial installation.
- `function _plugin_update --on-event plugin_update`: Runs after an update.
- `function _plugin_uninstall --on-event plugin_uninstall`: Runs before removal to clean up variables or bindings.

## Reference documentation
- [Fisher README](./references/github_com_jorgebucaran_fisher.md)