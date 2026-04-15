---
name: r-brio
description: The r-brio package provides high-performance functions for reading and writing UTF-8 encoded text files with explicit control over line endings. Use when user asks to read or write files using UTF-8 encoding, handle large files as single strings, manage Unix or Windows line endings, or detect file line endings.
homepage: https://cloud.r-project.org/web/packages/brio/index.html
---

# r-brio

name: r-brio
description: Efficient UTF-8 text input/output in R with explicit control over line endings. Use this skill when you need to read or write files while ensuring UTF-8 encoding, handling large files as single strings, or specifically managing Unix (\n) vs. Windows (\r\n) line endings. It is a high-performance alternative to base R functions for text I/O.

# r-brio

## Overview

The `brio` package provides functions for basic R input/output that always use UTF-8 encoding. It offers more explicit control over line endings than base R and is designed for performance and reliability in cross-platform environments. Key features include drop-in replacements for `readLines()` and `writeLines()` that bypass R's connection system for speed and consistency.

## Installation

```R
install.packages("brio")
```

## Core Functions

### Reading Text
- `read_lines(path, n = -1)`: Reads a file into a character vector (one element per line). Both `\n` and `\r\n` are treated as newlines.
- `read_file(path)`: Reads an entire file into a single length-1 character vector.
- `read_file_raw(path)`: Reads an entire file into a raw vector.
- `readLines(con, n = -1, ...)`: A drop-in replacement for `base::readLines()`. It only accepts file paths (not connections) and ignores arguments like `encoding` or `warn`.

### Writing Text
- `write_lines(text, path, eol = "\n")`: Writes a character vector to a file. You must explicitly set `eol` to `\r\n` for Windows line endings; it does not default based on the host OS.
- `write_file(text, path)`: Writes a length-1 character vector directly to a file without adding newlines.
- `write_file_raw(raw, path)`: Writes a raw vector to a file.
- `writeLines(text, con, sep = "\n", ...)`: A drop-in replacement for `base::writeLines()`. It converts text to UTF-8 and uses `sep` unconditionally.

### Utilities
- `file_line_endings(path)`: Detects the line endings used in a file. Returns `\n`, `\r\n`, or `NA`.

## Workflows and Examples

### Ensuring Cross-Platform Consistency
When writing files that must maintain Unix line endings even when generated on Windows:
```R
library(brio)
lines <- c("first line", "second line")
write_lines(lines, "output.txt", eol = "\n")
```

### Reading a Whole File for Processing
To read a configuration or template file as a single string:
```R
content <- read_file("template.txt")
```

### Checking File Line Endings
```R
endings <- file_line_endings("data.csv")
if (!is.na(endings) && endings == "\r\n") {
  message("File uses Windows line endings")
}
```

## Important Constraints
- **Connections**: `brio` functions work with file paths (strings), not R connection objects. Passing a connection to `readLines()` or `writeLines()` will throw an error.
- **Encoding**: All functions assume/force UTF-8. If you need to handle other encodings (like Latin-1), use base R or the `readr` package.
- **Embedded Nulls**: `brio` does not handle embedded null characters (`\0`) and may crash R if they are present in the input file.

## Reference documentation

- [brio: Basic R Input Output](./references/reference_manual.md)