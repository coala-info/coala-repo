---
name: lsd
description: "lsd is a modern directory listing tool that provides colorized output, icons, and a native tree-view mode. Use when user asks to list files with icons, visualize directory structures in a tree view, sort files by metadata, or display recursive directory sizes."
homepage: https://github.com/lsd-rs/lsd
---


# lsd

## Overview

lsd (LSDeluxe) is a modern, high-performance rewrite of the GNU `ls` command. It enhances the standard directory listing experience by incorporating icons (via Nerd Fonts), colorized output based on file types and permissions, and a native tree-view mode. It is designed to provide more context at a glance than traditional tools, making it easier to navigate large projects and identify file relationships.

## Command Line Usage

### Basic Navigation
- **Standard list**: `lsd`
- **Long format**: `lsd -l` (shows permissions, owner, size, and date)
- **Show all files**: `lsd -a` (includes hidden files starting with `.`)
- **Directory only**: `lsd -d` (lists the directory itself rather than its contents)

### Visual Enhancements
- **Tree view**: `lsd --tree` (visualizes the folder hierarchy)
- **Depth control**: `lsd --tree --depth 2` (limits the recursion depth of the tree)
- **Add headers**: `lsd -l --header` (adds a header row to the columns)
- **Total size**: `lsd -l --total-size` (calculates and displays the recursive size of directories)

### Sorting and Filtering
- **Sort by size**: `lsd -S` or `lsd --sizesort`
- **Sort by time**: `lsd -t` or `lsd --timesort`
- **Sort by extension**: `lsd -X` or `lsd --extension`
- **Sort by version**: `lsd -v` or `lsd --version` (useful for files with version numbers in names)
- **Reverse sort**: `lsd -r`

### Expert Tips
- **Git Integration**: In newer versions, `lsd` can display the Git status of files directly in the listing.
- **Human Readable**: Sizes are human-readable by default, but you can force specific units using `--size [default|short|bytes]`.
- **Icon Control**: If icons are not rendering correctly (due to font issues), use `--icon never` to disable them or `--icon always` to force them.
- **Permission Format**: Use `--permission [rwx|octal]` to toggle between symbolic and numeric permission displays.

## Configuration Locations

While `lsd` works out of the box, it looks for configuration files in the following directories:
- **Unix/macOS**: `~/.config/lsd/`
- **Windows**: `%USERPROFILE%\.config\lsd\` or `%APPDATA%\lsd\`

You can bypass these or point to a specific file using the `--config-file [PATH]` flag.

## Reference documentation
- [LSDeluxe README](./references/github_com_lsd-rs_lsd.md)
- [Release Tags and Feature History](./references/github_com_lsd-rs_lsd_tags.md)