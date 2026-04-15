---
name: diffutils
description: This tool compares files and directories to identify differences in content or byte-level data. Use when user asks to compare file contents, generate unified diffs for patches, perform recursive directory comparisons, or conduct byte-by-byte binary analysis.
homepage: https://github.com/uutils/diffutils
metadata:
  docker_image: "quay.io/biocontainers/diffutils:3.10"
---

# diffutils

## Overview
This skill provides guidance on using the `uutils/diffutils` suite, a modern Rust implementation of the classic GNU diff utilities. It is designed for developers and system administrators who need to compare file contents, create unified diffs for patching, or perform byte-by-byte comparisons of binary files. The tool aims for compatibility with GNU's functional behavior while leveraging Rust's safety and performance.

## CLI Usage and Patterns

### Basic File Comparison
Compare two files to see line-by-line differences:
```bash
diff file1.txt file2.txt
```

### Generating Unified Diffs
The unified format (`-u`) is the standard for creating patches. It provides context lines around changes, making it easier for tools like `patch` to apply the modifications.
```bash
diff -u old_version.txt new_version.txt > changes.patch
```

### Directory Comparison
Compare the contents of two directories recursively to find differing files:
```bash
diff -r dir1/ dir2/
```

### Binary Comparison with `cmp`
Use `cmp` for a low-level, byte-by-byte comparison. It is more efficient than `diff` for binary data or when you only need to know if files differ without seeing the specific text changes.
```bash
cmp file1.bin file2.bin
```
*   **Tip**: Use `-l` to print the byte numbers and values for all differing bytes.
*   **Tip**: Use `-s` (silent) to only get an exit code (0 if identical, 1 if different).

### Side-by-Side Comparison with `sdiff`
View differences in two columns for easier manual inspection:
```bash
sdiff file1.txt file2.txt
```

## Expert Tips
*   **Performance**: Since this is a Rust implementation, it is often faster than legacy versions for large files or deep directory trees.
*   **Exit Codes**: 
    *   `0`: No differences found.
    *   `1`: Differences were found.
    *   `2`: An error occurred (e.g., file not found).
*   **Whitespace Handling**: Use `-b` to ignore changes in the amount of white space, or `-w` to ignore all white space entirely when comparing code.



## Subcommands

| Command | Description |
|---------|-------------|
| cmp | Compare two files byte by byte. (Note: The provided help text contained a system error; arguments are based on standard diffutils cmp usage). |
| diff3 | Compare three files line by line. |

## Reference documentation
- [uutils/diffutils Repository Overview](./references/github_com_uutils_diffutils.md)
- [Project README and Examples](./references/github_com_uutils_diffutils_blob_main_README.md)