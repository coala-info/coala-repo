---
name: dos2unix
description: The `node-dos2unix` skill provides a programmatic way to handle line-ending conversions across multiple files.
homepage: https://github.com/JamesMGreene/node-dos2unix
---

# dos2unix

## Overview
The `node-dos2unix` skill provides a programmatic way to handle line-ending conversions across multiple files. Unlike the standard C-based utility, this implementation is designed for Node.js, offering asynchronous processing, event-driven feedback, and powerful globbing support. It is specifically useful for ensuring consistency in text-based assets (like source code or configuration files) when moving between Windows and Unix-like environments.

## Usage Patterns and Best Practices

### Programmatic Conversion
To use the tool, you must instantiate the `D2UConverter` and define your processing logic.

```javascript
var D2UConverter = require('dos2unix').dos2unix;

// Initialize with options
var d2u = new D2UConverter({
  glob: {
    cwd: __dirname // Set current working directory for globbing
  },
  maxConcurrency: 50 // Limit simultaneous file handles
});
```

### Globbing and Recursion
The tool supports standard glob patterns for selecting files.
- **Single File**: `d2u.process(['README.txt'])`
- **Directory (Non-recursive)**: `d2u.process(['docs/*'])`
- **Recursive Search**: Use the `**` pattern to process nested directories: `d2u.process(['src/**/*'])`
- **Multiple Patterns**: Pass an array to combine targets: `d2u.process(['docs/*.md', 'scripts/*.sh'])`

### Concurrency Management
On systems with limited resources or strict file handle limits, manage the `maxConcurrency` setting:
- **Default**: In version 1.1.1+, the default is `0` (unlimited).
- **Throttling**: Set a specific integer (e.g., `50`) to prevent "too many open files" errors during massive bulk operations.

### Event Handling
Since the process is asynchronous, always listen for events to manage the workflow:
- `error`: Triggered on file access issues or conversion failures.
- `end`: Triggered when all files in the glob pattern have been processed. Returns a `stats` object.
- `convert.start` / `convert.end`: Useful for logging individual file progress.

## Expert Tips
- **Directory Exclusion**: The tool automatically ignores directories in glob results (as of v1.0.2) to prevent errors during conversion.
- **Binary Safety**: While designed for text, ensure your glob patterns exclude binary files (like images or executables) to avoid data corruption, as the tool treats files as text streams.
- **Custom Glob Options**: You can override globbing behavior (like following symbolic links) by passing a `glob` object in the options, which adheres to the standard `glob` module documentation.

## Reference documentation
- [JamesMGreene/node-dos2unix README](./references/github_com_JamesMGreene_node-dos2unix.md)