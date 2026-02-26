---
name: diffutils
description: The diffutils tool compares files to identify differences or confirm identity using line-by-line text analysis or byte-by-byte binary comparison. Use when user asks to compare text files, generate unified patch files, identify differences in binary files, or check if two files are identical.
homepage: https://github.com/uutils/diffutils
---


# diffutils

## Overview

The diffutils skill provides a specialized workflow for using the Rust-based drop-in replacements for traditional GNU diff utilities. This toolset includes `diff` for line-by-line text comparison and `cmp` for byte-by-byte binary comparison. It is designed to be compatible with existing patch tools while offering the performance benefits of a modern Rust implementation. Use this skill to identify changes between file versions, create standard patch files, or quickly determine if two files are identical without reading their entire contents.

## Common CLI Patterns

### Text Comparisons with `diff`

The primary tool for finding differences in text files.

*   **Unified Diff (Standard for Patches)**:
    Use the `-u` flag to generate a unified diff, which is the standard format for code patches and version control systems.
    `diff -u old_file.txt new_file.txt`

*   **Brief Output**:
    If you only need to know if files differ without seeing the specific changes, use the `-q` (quiet) flag.
    `diff -q file1.txt file2.txt`

*   **Ignore Whitespace**:
    To focus on functional changes rather than formatting, use flags to ignore whitespace.
    `diff -b file1.txt file2.txt` (ignores changes in the amount of white space)
    `diff -w file1.txt file2.txt` (ignores all white space)

### Binary Comparisons with `cmp`

Used for comparing two files byte-by-byte.

*   **Find First Difference**:
    The default behavior reports the byte and line number of the first difference.
    `cmp file1.bin file2.bin`

*   **Detailed Byte Differences**:
    Use the `-l` flag to print the decimal byte number and the octal values for all differing bytes.
    `cmp -l file1.bin file2.bin`

*   **Silent Mode**:
    Use `-s` for scripts where you only care about the exit code (0 if identical, 1 if different).
    `cmp -s file1.bin file2.bin`

## Expert Tips

*   **Patch Compatibility**: When generating diffs for others to use, always prefer the `-u` (unified) format. It provides context lines that allow the `patch` utility to apply changes even if line numbers have shifted slightly.
*   **Implementation Status**: Note that while `diff` and `cmp` are the most mature tools in this suite, `sdiff` and `diff3` are currently under active development in the uutils project. For complex three-way merges, verify the current implementation status of `diff3`.
*   **Performance**: For very large files, `cmp` is significantly faster than `diff` because it stops at the first differing byte and does not attempt to calculate an edit script or alignment.
*   **Exit Codes**:
    *   0: No differences found.
    *   1: Differences were found.
    *   2: An error occurred (e.g., file not found).

## Reference documentation

- [uutils/diffutils Main Repository](./references/github_com_uutils_diffutils.md)
- [uutils/diffutils Issues and Status](./references/github_com_uutils_diffutils_issues.md)