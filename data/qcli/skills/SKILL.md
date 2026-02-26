---
name: qcli
description: LogiQCLI is an intelligent command-line interface that integrates AI capabilities into the terminal for specialized coding, debugging, and file management workflows. Use when user asks to switch operational modes, manage API keys, perform precise file edits, search codebases using regex, or retrieve library documentation.
homepage: https://github.com/xyOz-dev/LogiQCLI
---


# qcli

## Overview
LogiQCLI is an intelligent, extensible command-line interface designed to integrate AI capabilities directly into the developer terminal. It facilitates specialized workflows through "Modes" (such as Code, Architect, and Debug) and provides a robust set of tools for precise file manipulation, codebase searching, and documentation retrieval. Use this skill to navigate the CLI's command structure and leverage its agent-based file management system.

## Core Commands
- **/addkey**: Initialize your environment by adding API keys for providers (LMStudio, OpenRouter, Requesty).
- **/mode [list|set]**: Switch operational modes to change the AI's behavior (e.g., switching to 'Debug' for troubleshooting).
- **/workspace**: View or update the active directory where tools will perform file operations.
- **/settings interactive**: Access a guided configuration menu for application preferences.
- **/compress**: Optimize long sessions by keeping only the first and last three messages in the chat history.
- **/clear**: Reset the display and chat history for a fresh context.

## Tool-Specific Best Practices
When the agent is executing tasks within LogiQCLI, prioritize the following tool patterns:

### Precise File Editing
- **apply_diff**: Use this for targeted changes. It requires an exact match of the content to be replaced, making it the safest method for small, specific edits.
- **write_file**: Use only when creating a new file or completely replacing the contents of an existing one.
- **append_file**: Ideal for logs or adding new exports to the end of configuration files without reading the whole file first.

### Searching and Refactoring
- **search_files**: Use regex patterns to locate specific logic or variable declarations across the entire workspace.
- **search_and_replace**: Best for global refactoring (e.g., renaming a variable across a file). It supports regex for complex pattern matching.

### Navigation and Inspection
- **read_file_by_line_count**: When dealing with large source files, use this to preview the header or specific sections to save on token usage.
- **backup_commands**: Always list or create backups before performing destructive operations like `delete_file` or complex `search_and_replace` tasks.

### Documentation Retrieval
- **resolve_library_id**: If a library name is ambiguous, run this first to get the correct ID.
- **get_library_docs**: Use the resolved ID to fetch the latest API references and code examples directly into the session.

## Expert Tips
- **Global Access**: On macOS, ensure the `logiq` alias is created via `sudo ln -sf` to run the tool from any directory.
- **Self-Contained Execution**: LogiQCLI runs on .NET 9.0; if building from source, use the `build-release.sh` script to generate architecture-specific binaries (osx-arm64 for Apple Silicon).
- **Token Optimization**: Use `/compress` frequently during long debugging sessions to prevent the context window from becoming saturated with old logs.

## Reference documentation
- [LogiQCLI Main Repository](./references/github_com_xyOz-dev_LogiQCLI.md)