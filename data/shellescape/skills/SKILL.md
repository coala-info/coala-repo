---
name: shellescape
description: The `shellescape` tool provides a deterministic way to transform strings into shell-safe arguments.
homepage: https://github.com/alessio/shellescape
---

# shellescape

## Overview
The `shellescape` tool provides a deterministic way to transform strings into shell-safe arguments. It primarily works by wrapping strings in single quotes and properly escaping any internal single quotes. This ensures that the shell treats the entire string as a single literal argument rather than interpreting special characters like `*`, `$`, or `;`. The package includes a Go library for programmatic escaping and the `escargs` command-line utility for processing text streams.

## CLI Usage with escargs
The `escargs` utility reads lines from standard input and outputs their shell-escaped equivalents.

### Basic Transformation
To see how a string will be escaped:
```bash
echo "O'Reilly's File.txt" | escargs
# Output: 'O'\''Reilly'\''s File.txt'
```

### Processing Lists
Use `escargs` to prepare a list of raw strings (e.g., filenames from a text file) for use in a shell command:
```bash
cat filenames.txt | escargs
```

### Difference from xargs
Unlike `xargs`, `escargs` does not discard blank lines. This makes it safer for preserving the exact structure of input data when passing it through a pipeline to another tool that expects a specific line count.

## Go Library Integration
When writing Go applications that generate shell commands or scripts, use the `shellescape` package to sanitize inputs.

### Implementation Pattern
1. Import the package: `al.essio.dev/pkg/shellescape`
2. Use `shellescape.Quote()` to wrap variables.

```go
package main

import (
    "fmt"
    "al.essio.dev/pkg/shellescape"
)

func main() {
    userInput := "data; rm -rf /"
    // Safely format a command string
    safeCmd := fmt.Sprintf("ls -l %s", shellescape.Quote(userInput))
    fmt.Println(safeCmd) 
    // Output: ls -l 'data; rm -rf /'
}
```

## Best Practices
- **Avoid Manual Escaping**: Do not attempt to manually add quotes or backslashes to strings. Shell parsing rules are complex; use `shellescape.Quote()` to handle edge cases like nested quotes and shell metacharacters.
- **Sanitize All External Input**: Any string originating from a user, environment variable, or external file should be escaped before being concatenated into a command string.
- **Pipeline Safety**: When building complex shell pipelines, use `escargs` to ensure that filenames with spaces or symbols do not break subsequent commands in the chain.
- **Tokenization**: For advanced use cases where you need to split a shell-quoted string back into individual tokens, use the `ScanTokens` function provided by the library.

## Reference documentation
- [shellescape README](./references/github_com_alessio_shellescape.md)
- [escargs Command Details](./references/github_com_alessio_shellescape_tree_master_cmd_escargs.md)