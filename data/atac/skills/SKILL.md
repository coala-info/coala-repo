---
name: atac
description: ATAC is a high-performance terminal user interface for developing, testing, and managing API requests and collections. Use when user asks to test APIs from the terminal, import Postman or OpenAPI collections, manage environment variables, or perform authenticated requests using a TUI.
homepage: https://github.com/Julien-cpsn/ATAC
metadata:
  docker_image: "quay.io/biocontainers/atac:2008--py39pl5321h4846b57_8"
---

# atac

## Overview
`atac` (Arguably a Terminal API Client) is a high-performance, Rust-based TUI tool for API development and testing. It provides a Postman-like experience directly in the terminal, supporting request collections, environment management, and scripting. It is built for speed, privacy (offline-first), and seamless integration into terminal-centric workflows.

## Core Usage
- **Launch**: Simply run `atac` in your terminal to open the interactive interface.
- **Help**: Use `atac --help` to view available command-line arguments and version information.
- **Installation**:
  - Cargo: `cargo install atac --locked`
  - Homebrew: `brew install atac`
  - Arch Linux: `pacman -S atac`

## Key Features & Workflows
- **Request Management**: Organize requests into collections and workspaces.
- **Importing**: Supports importing existing data from:
  - Postman Collections
  - OpenAPI Specifications
  - cURL commands
- **Authentication**: Native support for JWT (JSON Web Tokens) and Digest Authentication.
- **Scripting**: Use JavaScript for pre-request and post-request logic (powered by the Boa engine).
- **Environment Variables**: Manage different environments and use variables in URLs or headers using `.env` files.

## Expert Tips
- **Vim Navigation**: Leverage Vim-like keybindings for efficient navigation within the TUI.
- **Clipboard**: Use the built-in clipboard integration to quickly copy response bodies or headers.
- **Syntax Highlighting**: Take advantage of automatic syntax highlighting for JSON, TOML, and other response formats.
- **Image Support**: View response images directly in the terminal if your terminal emulator supports it (via `ratatui-image`).
- **NeoVim Integration**: For users of NeoVim, a floating window plugin (`atac.nvim`) is available to use the tool without leaving the editor.

## Reference documentation
- [ATAC Main Repository](./references/github_com_Julien-cpsn_ATAC.md)