---
name: elph
description: The elph skill enables the use of the Elpher client within Emacs to browse Gopher, Gemini, and Finger protocols. Use when user asks to access non-HTTP small web content, navigate Gopher or Gemini spaces, or view text-heavy protocols directly in Emacs.
homepage: https://github.com/emacsmirror/elpher
---


# elph

## Overview
The elph skill facilitates the use of the Elpher client, a specialized browser for Emacs designed to access Gopher and Gemini "small web" spaces. It transforms Emacs into a high-performance, keyboard-centric tool for exploring text-heavy protocols, supporting secure TLS connections, image rendering, and the Finger protocol. This skill is best utilized when a user needs to browse non-HTTP content without leaving their development environment.

## Usage Patterns

### Core Navigation
- **Launch**: Execute `M-x elpher` to open the browser and its start page.
- **Link Selection**: Use `TAB` to move to the next link and `Shift-TAB` for the previous one. Press `RET` to follow the selected link.
- **Backtracking**: Press `u` to go back to the previous page. Elph caches page content and your cursor position, allowing for instant, stateful navigation.
- **Refreshing**: Press `R` to force a reload of the current page, which is particularly useful for updating search query results.

### Efficient Browsing
- **Menu Jumping**: Press `m` to jump directly to a specific link or menu item by typing its name (supports autocompletion).
- **Protocol Handling**: Elph automatically handles `gopher://`, `gemini://`, and `finger://` URIs. It also supports "Gophers" (Gopher over TLS) for encrypted connections.
- **Image Viewing**: Images are rendered directly within the Emacs buffer when encountered in Gopher or Gemini space.

### Configuration and Integration
- **Customization**: Use `M-x customize-group RET elpher RET` to modify faces, the start page, and connection settings.
- **Evil-mode**: The tool is compatible with `evil-mode` out-of-the-box, allowing Vim-style motion commands for navigation.
- **Bookmarks**: Use the built-in bookmarking system to save frequently visited sites across sessions.

### Expert Tips
- **Search Engines**: Use the `R` command on search result pages to quickly submit a new query to the same engine.
- **TLS Certificates**: For Gemini sites requiring client certificates, elph provides prompts to manage and remember certificate associations for specific URLs.

## Reference documentation
- [Elpher README](./references/github_com_emacsmirror_elpher_blob_master_README.md)
- [Elpher Project Page](./references/github_com_emacsmirror_elpher.md)