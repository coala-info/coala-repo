---
name: mypy
description: "Mypy performs static type checking for Python code to identify errors before runtime. Use when user asks to check types, perform static analysis, catch type-related bugs, or run mypy in strict mode."
homepage: https://github.com/python/mypy
---


# mypy

## Overview
Mypy acts as a static analysis layer for Python, validating that variables and functions are used according to their declared types. By checking code before runtime, it catches common errors such as unsupported operations, incompatible assignments, and invalid function arguments. It is designed for gradual typing, meaning you can introduce type safety to a codebase at your own pace without breaking existing dynamic logic.

## Installation
Install the latest stable version via pip:
```bash
python3 -m pip install -U mypy
```
To install an interpreted (non-compiled) version:
```bash
python3 -m pip install --no-binary mypy -U mypy
```

## Common CLI Patterns

### Basic Type Checking
Run mypy on a specific file or an entire directory:
```bash
mypy script.py
mypy src/
```

### Performance: Daemon Mode (dmypy)
For large codebases, use the daemon mode to keep mypy in memory for sub-second incremental updates:
```bash
dmypy run -- PROGRAM
```

### Strictness and Configuration
*   **Strict Mode**: Enables all optional error checking flags. Recommended for new projects.
    ```bash
    mypy --strict <target>
    ```
*   **Ignore Missing Imports**: Use when third-party libraries lack type stubs to prevent "module not found" errors.
    ```bash
    mypy --ignore-missing-imports <target>
    ```
*   **Enhanced Output**: Improve readability and debugging.
    ```bash
    mypy --pretty --show-error-codes <target>
    ```

## Expert Tips

### Gradual Typing and Suppression
*   **Ignore specific lines**: Use `# type: ignore` to skip checking on a specific line.
*   **Targeted suppression**: Use `# type: ignore[error-code]` (e.g., `[attr-defined]`) to ignore only specific issues while keeping other checks active.
*   **Cast**: Use `typing.cast(Type, value)` to force mypy to treat a variable as a specific type when inference fails.

### Integration
Mypy integrates with most major editors (VS Code, Vim, Emacs, PyCharm) and can be used as a pre-commit hook. Note that using it via pre-commit may limit its ability to analyze third-party dependencies unless configured to run in the local environment.

## Reference documentation
- [Mypy README](./references/github_com_python_mypy.md)
- [Mypy Wiki](./references/github_com_python_mypy_wiki.md)