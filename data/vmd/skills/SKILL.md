---
name: vmd
description: vmd is an Electron-based Markdown viewer that provides a high-fidelity preview of how Markdown files will appear on GitHub.
homepage: https://github.com/yoshuawuyts/vmd
---

# vmd

## Overview
vmd is an Electron-based Markdown viewer that provides a high-fidelity preview of how Markdown files will appear on GitHub. It excels as a "live" companion to text editors because it automatically watches files for changes and refreshes the view instantly. Beyond simple file viewing, it supports standard input, allowing you to pipe text from other processes directly into a rendered window.

## Core CLI Patterns

### Basic File Viewing
Open a specific file or the default README in the current directory:
- `vmd DOCUMENT.md` - Opens a specific Markdown file.
- `vmd` - Automatically looks for `README.md` in the current directory.
- `vmd path/to/folder/` - Automatically looks for a `README.md` within that folder.

### Piping and Standard Input
Render output from other commands directly into a vmd window:
- `cat file.md | vmd` - Pipes file content to the viewer.
- `npm view <package> readme | vmd` - Quickly read a package's documentation without leaving the terminal.
- `curl -s https://raw.githubusercontent.com/.../README.md | vmd` - Preview remote files.

### Window Management
- **New Windows**: Hold `Shift` while dragging and dropping a file onto an open vmd window to open it in a new instance.
- **Navigation**: Use `Shift + Click` on relative links to open the linked document in a new window.

## Configuration and Customization

### Display Options
Adjust the interface and rendering behavior via CLI flags:
- `--zoom=1.25` - Scales the UI and text (useful for high-DPI displays or presentations).
- `--devtools` - Opens the window with Chrome Developer Tools active for debugging styles.
- `--window-autohidemenubar=true` - (Linux/Windows) Hides the menu bar by default; toggle with the `Alt` key.

### Styling and Themes
- `--list-highlight-themes` - Shows all available code block syntax themes.
- `--highlight-theme=monokai` - Sets a specific syntax theme for code blocks.
- `--styles-main=custom.css` - Replaces the default GitHub styling with a custom CSS file.
- `--styles-extra=overrides.css` - Applies additional CSS on top of the default styles.

### Front Matter Support
vmd renders YAML front matter as a table by default. You can modify this behavior:
- `--frontmatter-formats=YAML,TOML,JSON` - Enables support for additional metadata formats.
- `--frontmatter-renderer=none` - Hides the front matter block entirely.
- `--frontmatter-renderer=code` - Displays the front matter as a raw code block.

## Expert Tips
- **File Watching**: vmd uses native file system watching. If you are using an editor that performs "atomic saves" (writing to a temp file then renaming), vmd handles the update seamlessly.
- **Clipboard Integration**: You can copy images from the vmd window in binary format to paste directly into image editors, or copy local file paths/links via the context menu.
- **Search**: Use `Ctrl+F` (or `Cmd+F`) to trigger an in-page search, which is particularly useful for long technical specifications.

## Reference documentation
- [vmd README](./references/github_com_yoshuawuyts_vmd.md)