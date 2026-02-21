---
name: tendo
description: The `tendo` module provides a suite of "missing" Python functionalities.
homepage: https://github.com/phom9/tendo
---

# tendo

## Overview
The `tendo` module provides a suite of "missing" Python functionalities. It is particularly valuable for CLI tool developers who need to ensure their scripts don't run concurrently (singleton pattern), or who require consistent terminal behavior across Windows and Unix systems. Use this skill to implement robust script locking, enhanced logging aesthetics, and reliable external command execution.

## Functional Usage and Best Practices

### Preventing Multiple Script Instances
The most common use case for `tendo` is ensuring that only one instance of a script runs at a time. This is handled by the `singleton` module, which creates a lock file that is automatically released when the script exits.

```python
from tendo import singleton
try:
    me = singleton.SingleInstance()
except singleton.SingleInstanceException:
    # Another instance is already running
    import sys
    sys.exit(-1)
```

### Terminal and Logging Coloring
`tendo` provides a `colorer` module that enhances standard Python logging by adding colors to the console output. It is designed to work on both Unix and Windows.

- **Automatic Integration**: Simply importing the module can often initialize the coloring for the root logger.
- **Manual Debugging**: You can run `python -m tendo.colorer` to check the current terminal's color support and debug information.

### Advanced Command Execution (Tee)
The `tee` module allows you to execute external programs while simultaneously capturing their output in a variable and displaying it in the console.

- **system2()**: Use `tendo.tee.system2(command)` to execute a shell command. It returns a tuple containing the `(error_code, lines)`, where `lines` is a list of strings from the command's output.
- **Windows Workarounds**: `tendo` includes specific fixes for Windows `_popen()` bugs related to long command lines (exceeding 250 characters).

### Unicode File Operations
The `unicode` module provides a wrapper for file operations to handle Byte Order Marks (BOM) and encoding silently.

- **unicode.open()**: Use this as a drop-in replacement for the standard `open()` when you need consistent behavior across different Python versions (2.5 through 3.x) regarding text file operations.

### Executing Python Scripts in Namespace
The `execfile2()` function extends the standard `execfile` capability. It allows you to:
- Execute a script within the `__main__` namespace.
- Alter the command line arguments (`sys.argv`) for the script being executed.

## Reference documentation
- [tendo Overview](./references/anaconda_org_channels_bioconda_packages_tendo_overview.md)
- [tendo GitHub README](./references/github_com_phom9_tendo.md)
- [tendo Commit History](./references/github_com_phom9_tendo_commits_master.md)