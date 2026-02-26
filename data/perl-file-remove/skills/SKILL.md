---
name: perl-file-remove
description: This tool provides a reliable interface for recursively deleting files and directories and handling complex globbing patterns. Use when user asks to delete files or directories, clear directory contents, or remove files using wildcards and globs.
homepage: http://metacpan.org/pod/File::Remove
---


# perl-file-remove

## Overview
The `perl-file-remove` skill provides a reliable interface for deleting filesystem objects. While standard Perl functions like `unlink` often fail on directories or require manual recursion, this tool automates the process of traversing directory trees and clearing contents to ensure successful removal. It is designed to be "safe" by ignoring non-existent targets and handling complex globbing patterns that might otherwise require external shell calls.

## Usage Guidelines

### Core Functions
The module provides two primary functions that should be used based on the target type:

- **remove()**: The primary function for deleting files and directories.
- **clear()**: Used when you want to delete the *contents* of a directory but keep the directory itself.

### Common Patterns

**1. Recursive Directory Removal**
To delete a directory and everything inside it, pass the path directly to `remove`.
```perl
use File::Remove 'remove';

# Deletes the folder and all nested files/folders
remove(\1, 'path/to/directory');
```
*Note: The `\1` (recursive flag) is often the default in modern versions, but explicit passing ensures behavior.*

**2. Using Wildcards and Globs**
The tool excels at processing shell-style globs without spawning a subshell.
```perl
# Remove all .tmp files in the current directory
remove('*.tmp');

# Remove all log files in any subdirectory
remove('logs/*.log');
```

**3. Safe Deletion (Trash Integration)**
On supported platforms, you can move files to the trash/recycle bin instead of permanent deletion.
```perl
use File::Remove 'trash';
trash('important_document.txt');
```

### Best Practices
- **Error Handling**: `remove` returns the number of items successfully deleted. Always check this value if the deletion is critical to the workflow.
- **Platform Independence**: Use this tool instead of `system("rm -rf ...")` to ensure your Perl scripts work on both Unix-like systems and Windows.
- **Undeletable Files**: If a file is read-only, `File::Remove` will attempt to change permissions to delete it, which is more aggressive than standard `unlink`.

## Reference documentation
- [File::Remove Documentation](./references/metacpan_org_pod_File__Remove.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-remove_overview.md)