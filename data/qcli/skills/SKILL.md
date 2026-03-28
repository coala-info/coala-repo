---
name: qcli
description: qcli is a terminal-based agent framework that manages AI model interactions and local file operations. Use when user asks to switch AI models or modes, perform precise file manipulations like applying diffs, manage workspace configurations, or search and document project libraries.
homepage: https://github.com/xyOz-dev/LogiQCLI
---

# qcli

## Overview
LogiQ CLI (qcli) is a terminal-based agent framework that bridges the gap between local development environments and various AI providers. It allows for seamless switching between specialized operational modes and provides a suite of tools for precise file manipulation, history management, and workspace configuration. This skill provides the procedural knowledge required to navigate its command structure and utilize its integrated development tools effectively.

## Command Reference

### Configuration and Setup
*   **/addkey**: Initialize or add a new API key. You will be prompted for a nickname to allow for easy switching later.
*   **/switchkey**: Toggle between different saved API provider keys.
*   **/settings interactive**: Launch the guided configuration menu to adjust application preferences.
*   **/workspace**: View or update the active directory where the CLI performs file operations.

### Model and Mode Management
*   **/model**: Check the currently active AI model or change it to a different supported version.
*   **/models**: Open the management interface for the available models list.
*   **/mode [list | <name>]**: Switch between operational behaviors:
    *   **Code**: Optimized for writing and refactoring.
    *   **Architect**: Best for high-level design and project structure.
    *   **Debug**: Focused on error analysis and troubleshooting.

### Session Control
*   **/clear**: Reset the current chat history and clear the terminal display.
*   **/compress**: Optimize the context window by keeping only the first message and the three most recent messages.
*   **/exit** or **quit**: Safely terminate the session.

## Integrated Tool Usage

### File Manipulation
*   **apply_diff**: Use this for precise, targeted edits. It requires an exact match of the original text to ensure no accidental changes occur in surrounding code.
*   **search_and_replace**: Best for global refactoring (e.g., renaming a variable across a whole file). Supports regex patterns.
*   **create_file**: Standard method for adding new files; it includes safety checks to prevent overwriting existing data.
*   **append_file**: Adds content to the end of a file; useful for logging or updating configuration lists.

### Project Navigation
*   **search_files**: Execute regex searches across the entire workspace to find specific mentions or configurations.
*   **backup_commands**: Manage the local version history. Use this to `list`, `restore`, or `compare` previous versions of files before and after AI edits.

### Documentation and Research
*   **resolve_library_id**: Find the specific identifier for a software library.
*   **get_library_docs**: Fetch up-to-date documentation and code examples for a resolved library ID to ensure the AI is working with current API standards.

## Best Practices
*   **Context Management**: Regularly use `/compress` during long sessions to prevent performance degradation and stay within model token limits.
*   **Safety First**: Always verify the current workspace with `/workspace` before running tools that modify files.
*   **Mode Switching**: Don't stay in 'Code' mode for architectural discussions; switching to 'Architect' provides the agent with better high-level heuristics.



## Subcommands

| Command | Description |
|---------|-------------|
| diff | Compare FILES line by line. |
| file | Determine type of FILEs. |
| file | Determine type of FILEs. |
| id | Print user and group information for the specified USER, or (when USER omitted) for the current user. |

## Reference documentation
- [LogiQCLI README](./references/github_com_xyOz-dev_LogiQCLI_blob_main_README.md)